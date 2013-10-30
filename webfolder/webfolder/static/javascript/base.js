$(document)
  .ready(function() {

    // DropDowns
    $('.ui.dropdown')
      .dropdown({
      on: 'hover'
    })
    ;

    // Actions
    $('.delete_modal')
     .modal('setting', 'closable', false)
     .modal('attach events', '.delete_button', 'show');

  })
;
