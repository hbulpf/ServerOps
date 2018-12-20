( function( $ ) {
	$( document ).on( "click", '.hctpc_reload_button, .wpcf7-submit', function() {
		hctpc_reload( $( this ) );
	}).on( "touchstart", function( event ) {
		event = event || window.event;
		var item = $( event.target );
		if ( hctpc_vars.enlarge == '1' ) {
			var element = $( event.target );
			if ( element.hasClass( 'hctpc_img' ) ) {
				event.preventDefault();
				element.toggleClass( 'hctpc_reduce' );
				$( '.hctpc_img' ).not( element ).removeClass( 'hctpc_reduce' );
			} else {
				$( '.hctpc_img' ).removeClass( 'hctpc_reduce' );
			}
		}
		if ( item.hasClass( 'hctpc_reload_button' ) || item.attr( 'name' ) == 'ac_form_submit' )
			hctpc_reload( item );
	}).ready( function() {
		if ( $( '.hctpc_recognition' ).length ) {
			$( '.hctpc_recognition' ).each( function() {				
				$( this ).find( '.hctpc_input' ).css( 'width', $( this ).find( '.hctpc_images_wrap' ).css( 'width' ) );
			} );
		}

		var ajax_containers = $( '.hctpc_ajax_wrap' );

		if ( ! ajax_containers.length )
			return;

		ajax_containers.each( function() {
			hctpc_reload( $( this ), true );
		});
	});
})(jQuery);

/**
 * Reload captcha
 */
function hctpc_reload( object, is_ajax_load ) {
	is_ajax_load = is_ajax_load || false;
	(function($) {
		if  ( is_ajax_load ) {
			var captcha = object;
		} else {
			var captcha = object.hasClass( 'hctpc_reload_button' ) ? object.parent().parent( '.hctpc_wrap' ) : object.closest( 'form' ).find( '.hctpc_wrap' );
		}
		var button  = captcha.find( '.hctpc_reload_button' );
		if ( ! captcha.length || button.hasClass( 'hctpc_active' ) )
			return false;
		button.addClass( 'hctpc_active' );
		var captcha_block = captcha.parent(),
			input         = captcha.find( 'input:text' ),
			input_name    = is_ajax_load ? captcha.attr( 'data-hctpc-input' ) : input.attr( 'name' ),
			input_class   = is_ajax_load ? captcha.attr( 'data-hctpc-class' ) : input.attr( 'class' ).replace( /hctpc_input/, '' ).replace( /^\s+|\s+$/g, '' ),
			form_slug     = is_ajax_load ? captcha.attr( 'data-hctpc-form' ) : captcha_block.find( 'input[name="hctpc_form"]' ).val();
		$.ajax({
			type: 'POST',
			url: hctpc_vars.ajaxurl,
			data: {
				action:              'hctpc_reload',
				hctpc_nonce:       hctpc_vars.nonce,
				hctpc_input_name:  input_name,
				hctpc_input_class: input_class,
				hctpc_form_slug:   form_slug
			},
			success: function( result ) {
				captcha_block.find( '.hctpc_to_remove' ).remove();
				if ( input_class === '' )
					captcha.replaceWith( result ); /* for default forms */
				else
					captcha_block.replaceWith( result ); /* for custom forms */

				if ( $( result ).hasClass( 'hctpc_recognition' ) || $( result ).find( '.hctpc_wrap' ).hasClass( 'hctpc_recognition' ) ) {
					$( '.hctpc_recognition' ).each( function() {				
						$( this ).find( '.hctpc_input' ).css( 'width', $( this ).find( '.hctpc_images_wrap' ).css( 'width' ) );
					} );
				}
			},
			error : function ( xhr, ajaxOptions, thrownError ) {
				alert( xhr.status );
				alert( thrownError );
			}
		});
	})(jQuery);
}