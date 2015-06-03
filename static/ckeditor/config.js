/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	 config.language = 'en';
	// config.uiColor = '#AADC6E';
//	config.toolbar = [
//	    [ 'Bold', 'Italic', 'Underline','Strikethrough','Subscript' ,'Superscript','Remove Format']
//	];
	config.toolbarGroups = [
	    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup'] },
	    { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] },
	    {name:'colors'},
//	    '/',
	    { name: 'links' },
	    { name: 'insert' },
	    { name: 'tools' },
	    { name: 'others' }
	];
	config.filebrowserUploadUrl = '/up/file';
	config.autoGrow_bottomSpace = 0;
};
