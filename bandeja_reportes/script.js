document.addEventListener('DOMContentLoaded', () => {
    const notificationPanel = document.getElementById('notification-panel');
    const notificationsList = document.getElementById('notifications-list');
  
    // Función para cargar notificaciones desde el localStorage
    function loadNotifications() {
      const notifications = JSON.parse(localStorage.getItem('notifications')) || [];
      notificationsList.innerHTML = ''; // Limpiar la lista actual
  
      notifications.forEach((notification) => {
        const notificationItem = document.createElement('p');
        notificationItem.innerHTML = `${notification} <button class="delete">Eliminar</button>`;
        notificationsList.appendChild(notificationItem);
      });
    }
  
    // Función para guardar una nueva notificación en el localStorage
    function addNotification(notification) {
      const notifications = JSON.parse(localStorage.getItem('notifications')) || [];
      notifications.push(notification);
      localStorage.setItem('notifications', JSON.stringify(notifications));
      loadNotifications();
    }
  
    // Capturar datos enviados desde el formulario de reporte
    const formReporte = document.getElementById('form-reporte');
    formReporte.addEventListener('submit', (event) => {
      event.preventDefault();
  
      const tipoProblema = document.getElementById('tipo_problema').value;
      const descripcionDetallada = document.getElementById('descripcion_detallada').value;
      const fechaHoraInicio = document.getElementById('fecha_hora_inicio').value;
      const afectacionServicio = document.getElementById('afectacion_servicio').value;
  
      // Crear notificación con la información del formulario
      const nuevaNotificacion = `
        Tipo de problema: ${tipoProblema}, 
        Descripción: ${descripcionDetallada}, 
        Fecha y hora: ${fechaHoraInicio}, 
        Afectación: ${afectacionServicio}
      `;
  
      // Guardar notificación y mostrarla en la bandeja
      addNotification(nuevaNotificacion);
      alert('Reporte enviado correctamente');
    });
  
    // Cargar notificaciones al inicio
    loadNotifications();
  
    // Delegar eventos para eliminar notificaciones
    notificationsList.addEventListener('click', (e) => {
      if (e.target.classList.contains('delete')) {
        e.target.parentElement.remove();
        const notificationText = e.target.parentElement.textContent.replace('Eliminar', '').trim();
        let notifications = JSON.parse(localStorage.getItem('notifications')) || [];
        notifications = notifications.filter(n => n !== notificationText);
        localStorage.setItem('notifications', JSON.stringify(notifications));
      }
    });
  });
  