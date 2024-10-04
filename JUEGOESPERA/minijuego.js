const config = {
  type: Phaser.AUTO,
  width: 1024, // Mantener el tamaño
  height: 768,
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

let game;
let isGameRunning = false;

document.getElementById('start-btn').addEventListener('click', function() {
  document.getElementById('game-container').innerHTML = ''; // Eliminar las instrucciones
  game = new Phaser.Game(config);
});

let player, cursors, bullets, enemies;
let score = 0, lives = 3;
let scoreText, livesText;
let lastFired = 0, enemyTimer = 0;
let spawnInterval = 800, enemySpeed = -200, difficultyTimer = 0;
let isGameOver = false;

function preload() {
  this.load.image('background', 'fondo.webp'); // Cargar imagen de fondo
  this.load.image('player', 'nave.png');
  this.load.image('bullet', 'misil.png');
  this.load.image('enemy', 'meteorito.png');
}

function create() {
  this.add.image(512, 384, 'background'); // Fondo centrado
  player = this.physics.add.sprite(100, 384, 'player').setScale(0.5);
  player.setCollideWorldBounds(true);

  bullets = this.physics.add.group({ classType: Bullet, runChildUpdate: true });
  enemies = this.physics.add.group();
  this.physics.add.collider(bullets, enemies, hitEnemy, null, this);
  this.physics.add.collider(player, enemies, hitPlayer, null, this);

  cursors = this.input.keyboard.createCursorKeys();
  this.input.keyboard.on('keydown-SPACE', shoot, this);

  scoreText = this.add.text(16, 16, 'Puntaje: 0', { fontSize: '32px', fill: '#fff' });
  livesText = this.add.text(16, 50, 'Vidas: 3', { fontSize: '32px', fill: '#fff' });
}

function update(time, delta) {
  if (!isGameOver) {
    enemyTimer += delta;
    if (enemyTimer > spawnInterval) {
      spawnEnemy();
      enemyTimer = 0;
    }

    difficultyTimer += delta;
    if (difficultyTimer > 5000) {
      enemySpeed -= 20;
      difficultyTimer = 0;
    }

    if (cursors.left.isDown) {
      player.setVelocityX(-300); // Aumentar velocidad
    } else if (cursors.right.isDown) {
      player.setVelocityX(300); // Aumentar velocidad
    } else {
      player.setVelocityX(0);
    }
    
    if (cursors.up.isDown) {
      player.setVelocityY(-300); // Aumentar velocidad
    } else if (cursors.down.isDown) {
      player.setVelocityY(300); // Aumentar velocidad
    } else {
      player.setVelocityY(0);
    }

    enemies.children.iterate(function (enemy) {
      if (enemy && enemy.x < -50) {
        enemy.destroy();
      }
    });
  }
}

function shoot() {
  if (game.getTime() - lastFired > 300) {
    const bullet = bullets.get();
    if (bullet) {
      bullet.fire(player.x + 50, player.y);
      lastFired = game.getTime();
    }
  }
}

function hitEnemy(bullet, enemy) {
  bullet.destroy();
  enemy.destroy();
  score += 10;
  scoreText.setText('Puntaje: ' + score);
}

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

function spawnEnemy() {
  const numberOfEnemies = Phaser.Math.Between(1, 4);
  for (let i = 0; i < numberOfEnemies; i++) {
    const enemy = enemies.create(1024, Phaser.Math.Between(50, 700), 'enemy');
    enemy.setVelocityX(enemySpeed);
  }
}

function gameOver(scene) {
  isGameOver = true;
  const gameOverText = scene.add.text(512, 384, 'GAME OVER\n ENTER para reiniciar', {
    fontSize: '50px',
    fill: '#fff',
    align: 'center'
  });
  gameOverText.setOrigin(0.5);
  scene.input.keyboard.once('keydown-ENTER', function () {
    gameOverText.destroy();
    restartGame(scene);
  });
}

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
    if (this.x > 1024) {
      this.setActive(false);
      this.setVisible(false);
    }
  }
}

function restartGame(scene) {
  score = 0;
  lives = 3;
  enemySpeed = -200;
  spawnInterval = 800;
  isGameOver = false;
  scoreText.setText('Puntaje: ' + score);
  livesText.setText('Vidas: ' + lives);
  player.clearTint();
  player.setPosition(100, 384);
  enemies.clear(true, true);
  scene.physics.resume();
}
