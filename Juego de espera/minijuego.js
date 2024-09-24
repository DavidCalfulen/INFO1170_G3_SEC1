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
let spawnInterval = 1000; // Intervalo de aparición de enemigos (en milisegundos)

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
  if (enemyTimer !== -1) { // Solo generar enemigos si no es Game Over
    enemyTimer += delta;
    if (enemyTimer > spawnInterval) {
      spawnEnemy();
      enemyTimer = 0; // Reiniciar el temporizador para la próxima aparición
    }
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

  // Aparición constante de enemigos
  enemyTimer += delta;
  if (enemyTimer > spawnInterval) {
    spawnEnemy();
    enemyTimer = 0; // Reiniciar el temporizador para la próxima aparición
  }

  // Verificar si algún enemigo ha salido de la pantalla y eliminarlo
  enemies.children.iterate(function (enemy) {
    if (enemy && enemy.x < -50) { // Fuera de la pantalla
      enemy.destroy();
    }
  });
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
  if (gameOverCondition) return; // No generar enemigos si es Game Over

  let enemy = enemies.create(Phaser.Math.Between(800, 1000), Phaser.Math.Between(100, 500), 'enemy');
  enemy.setVelocityX(-200);
  enemy.setCollideWorldBounds(true);
  enemy.setBounce(1);
}

// Final del juego
function gameOver(scene) {
  const gameOverText = scene.add.text(400, 300, 'GAME OVER\n ENTER para reiniciar', {
    fontSize: '50px',
    fill: '#fff',
    align: 'center'
  });
  gameOverText.setOrigin(0.5);

  // Detener la generación de enemigos y las físicas
  scene.time.removeAllEvents();  // Eliminar todos los eventos de tiempo (incluido el de los enemigos)
  scene.physics.pause();         // Pausar las físicas

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
  scoreText.setText('Puntaje: ' + score);
  livesText.setText('Vidas: ' + lives);
  player.clearTint();
  player.setPosition(100, 300);
  enemies.clear(true, true);    // Eliminar todos los enemigos en pantalla

  // Reiniciar las físicas y los eventos de tiempo
  scene.physics.resume();       // Reanudar las físicas
  scene.time.addEvent({         // Reiniciar la generación de enemigos
    delay: 1000,
    callback: spawnEnemy,
    callbackScope: scene,
    loop: true
  });
}