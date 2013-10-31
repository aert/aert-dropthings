$(document)
  .ready(function() {

    // DropDowns & Checkboxes
    $('.ui.dropdown').dropdown({ on: 'hover' });
    $('.ui.checkbox').checkbox();

    // Delete Modal
    $('.delete_modal')
     .modal('setting', 'closable', false)
     .modal('attach events', '.delete_button', 'show');

    // New Modal
    $('#modal_new_note').modal('attach events', '#button_new_note', 'show');
    $('#modal_new_links').modal('attach events', '#button_new_links', 'show');

  })
;
