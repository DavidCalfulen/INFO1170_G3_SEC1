const config = {
  type: Phaser.AUTO,
  width: 800,
  height: 600,
  physics: {
    default: 'arcade',
    arcade: {
      gravity: { y: 0 },
      debug: false
    }
  },
  scene: {
    preload: preload,
    create: create,
    update: update
  }
};

const game = new Phaser.Game(config);
let player;
let cursors;
let bullets;
let enemies;
let score = 0;
let scoreText;
let lives = 3;
let livesText;
let lastFired = 0;
let enemyTimer = 0;
let spawnInterval = 800; // Reducimos el intervalo para que aparezcan más enemigos (800ms)
let enemySpeed = -200; // Velocidad inicial de los enemigos
let difficultyTimer = 0; // Temporizador para aumentar la dificultad
let isGameOver = false; // Variable para manejar el estado de Game Over

function preload() {
  this.load.image('background', 'back.png');
  this.load.image('player', 'nave.png');
  this.load.image('bullet', 'misil.png');
  this.load.image('enemy', 'meteorito.png');
}

function create() {
  // Fondo
  this.add.image(400, 300, 'background');

  // Jugador
  player = this.physics.add.sprite(100, 300, 'player').setScale(0.5);
  player.setCollideWorldBounds(true);

  // Balas
  bullets = this.physics.add.group({
    classType: Bullet,
    runChildUpdate: true
  });

  // Enemigos
  enemies = this.physics.add.group();

  // Colisiones entre balas y enemigos
  this.physics.add.collider(bullets, enemies, hitEnemy, null, this);

  // Colisiones entre jugador y enemigos
  this.physics.add.collider(player, enemies, hitPlayer, null, this);

  // Crear controles
  cursors = this.input.keyboard.createCursorKeys();
  this.input.keyboard.on('keydown-SPACE', shoot, this);

  // Puntaje y vidas
  scoreText = this.add.text(16, 16, 'Puntaje: 0', { fontSize: '32px', fill: '#fff' });
  livesText = this.add.text(16, 50, 'Vidas: 3', { fontSize: '32px', fill: '#fff' });
}

function update(time, delta) {
  if (!isGameOver) {
    // Control del temporizador de enemigos
    enemyTimer += delta;
    if (enemyTimer > spawnInterval) {
      spawnEnemy();
      enemyTimer = 0;
    }

    // Aumentar la dificultad con el tiempo
    difficultyTimer += delta;
    if (difficultyTimer > 5000) { // Incrementa la dificultad cada 5 segundos
      enemySpeed -= 20; // Los enemigos se vuelven más rápidos
      difficultyTimer = 0; // Reiniciar el temporizador de dificultad
    }

    // Control del jugador
    if (cursors.left.isDown) {
      player.setVelocityX(-160);
    } else if (cursors.right.isDown) {
      player.setVelocityX(160);
    } else {
      player.setVelocityX(0);
    }

    if (cursors.up.isDown) {
      player.setVelocityY(-160);
    } else if (cursors.down.isDown) {
      player.setVelocityY(160);
    } else {
      player.setVelocityY(0);
    }

    // Verificar si algún enemigo ha salido de la pantalla y eliminarlo
    enemies.children.iterate(function (enemy) {
      if (enemy && enemy.x < -50) { // Fuera de la pantalla
        enemy.destroy();
      }
    });
  }
}

// Función para disparar
function shoot() {
  if (game.getTime() - lastFired > 300) {
    const bullet = bullets.get();
    if (bullet) {
      bullet.fire(player.x + 50, player.y);
      lastFired = game.getTime();
    }
  }
}

// Función cuando una bala golpea a un enemigo
function hitEnemy(bullet, enemy) {
  bullet.destroy();
  enemy.destroy();

  // Aumentar el puntaje
  score += 10;
  scoreText.setText('Puntaje: ' + score);
}

// Función cuando un enemigo golpea al jugador
function hitPlayer(player, enemy) {
  enemy.destroy();
  lives -= 1;
  livesText.setText('Vidas: ' + lives);

  if (lives === 0) {
    this.physics.pause();
    player.setTint(0xff0000);
    gameOver(this);
  }
}

// Función para generar enemigos aleatoriamente
function spawnEnemy() {
  const numberOfEnemies = Phaser.Math.Between(1, 4); // Genera entre 2 y 5 enemigos cada vez

  for (let i = 0; i < numberOfEnemies; i++) {
    const enemy = enemies.create(800, Phaser.Math.Between(50, 550), 'enemy');
    enemy.setVelocityX(enemySpeed); // La velocidad de los enemigos aumenta con el tiempo
  }
}

// Final del juego
function gameOver(scene) {
  isGameOver = true; // Indicar que el juego ha terminado
  const gameOverText = scene.add.text(400, 300, 'GAME OVER\n ENTER para reiniciar', {
    fontSize: '50px',
    fill: '#fff',
    align: 'center'
  });
  gameOverText.setOrigin(0.5);

  // Escuchar la tecla "enter" para reiniciar el juego
  scene.input.keyboard.once('keydown-ENTER', function () {
    gameOverText.destroy(); // Eliminar el texto de Game Over
    restartGame(scene);     // Reiniciar el juego
  });
}

// Clase de balas
class Bullet extends Phaser.Physics.Arcade.Sprite {
  constructor(scene, x, y) {
    super(scene, x, y, 'bullet');
  }

  fire(x, y) {
    this.body.reset(x, y);
    this.setActive(true);
    this.setVisible(true);
    this.setVelocityX(300);
  }

  preUpdate(time, delta) {
    super.preUpdate(time, delta);

    // Destruir la bala si sale de la pantalla
    if (this.x > 800) {
      this.setActive(false);
      this.setVisible(false);
    }
  }
}

function restartGame(scene) {
  score = 0;
  lives = 3;
  enemySpeed = -200; // Restablecer la velocidad de los enemigos
  spawnInterval = 800; // Restablecer el intervalo de aparición
  isGameOver = false; // Restablecer el estado del juego
  scoreText.setText('Puntaje: ' + score);
  livesText.setText('Vidas: ' + lives);
  player.clearTint();
  player.setPosition(100, 300);
  enemies.clear(true, true); // Eliminar todos los enemigos en pantalla
  scene.physics.resume(); // Reanudar las físicas
}
