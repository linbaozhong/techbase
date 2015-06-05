/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
//	 config.language = 'en';
	// config.uiColor = '#AADC6E';

	config.toolbar = [
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
		{ name: 'styles', items: [ 'Format' ] },
		{ name: 'paragraph', groups: [ 'list', 'blocks', 'align'], items: [ 'NumberedList', 'BulletedList', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
		{ name: 'colors', items: [ 'TextColor', 'BGColor', '-' ,'Link', 'Unlink', 'Anchor', '-' ,'Image', 'Flash', 'Table', 'HorizontalRule', 'SpecialChar' ] },
		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
		{ name: 'editing', groups: [ 'find'], items: [ 'Find', 'Replace'] },
		{ name: 'tools', items: [ 'Maximize', 'ShowBlocks' ] }
	];
	config.filebrowserUploadUrl = '/up/file';
	config.autoGrow_bottomSpace = 0;
};
