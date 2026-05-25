(function(){
  function canMove(from,to,card){
    if(from==='NEW' && to==='COMPLETED') return false;
    if((to==='IN_PROGRESS') && !card.dataset.assignee) return false;
    if(to==='COMPLETED' && from!=='WAITING_REVIEW') return false;
    return true;
  }
  document.querySelectorAll('.task-list').forEach(function(el){
    new Sortable(el,{group:'kanban',animation:150,onEnd:function(evt){
      var card=evt.item,from=evt.from.closest('.kanban-column').dataset.status,to=evt.to.closest('.kanban-column').dataset.status;
      if(!canMove(from,to,card)){ evt.from.appendChild(card); alert('Không đúng luồng xử lý'); return; }
      $.post('/api/task/change-status',{id_task:card.dataset.taskId,trang_thai_cu:from,trang_thai_moi:to});
    }});
  });
})();
