
use v6;

use GTK::Simple::NativeLib;
use NativeCall;

unit module GTK::Simple::Raw;

class GtkWidget is repr('CPointer') is export { }

# gtk_widget_... {{{

sub gtk_widget_show(GtkWidget $widgetw)
    is native(&gtk-lib)
    is export
    {*}

sub gtk_widget_hide(GtkWidget $widgetw)
    is native(&gtk-lib)
    is export    
    { * }

sub gtk_widget_show_all(GtkWidget $widgetw)
    is native(&gtk-lib)
    is export
    { * }

sub gtk_widget_set_no_show_all(GtkWidget $widgetw, int32 $no_show_all)
    is native(&gtk-lib)
    is export
    { * }

sub gtk_widget_get_no_show_all(GtkWidget $widgetw) 
    returns int32
    is native(&gtk-lib)
    is export
    { * }

sub gtk_widget_destroy(GtkWidget $widget)
    is native(&gtk-lib)
    is export
    {*}

sub gtk_widget_set_sensitive(GtkWidget $widget, int32 $sensitive)
    is native(&gtk-lib)
    is export

    {*}
sub gtk_widget_get_sensitive(GtkWidget $widget)
    returns int32
    is native(&gtk-lib)
    is export
    {*}

sub gtk_widget_set_size_request(GtkWidget $widget, int32 $w, int32 $h)
    is native(&gtk-lib)
    is export
    {*}

sub gtk_widget_get_allocated_height(GtkWidget $widget)
    returns int32
    is native(&gtk-lib)
    is export
    {*}

sub gtk_widget_get_allocated_width(GtkWidget $widget)
    returns int32
    is native(&gtk-lib)
    is export
    {*}

sub gtk_widget_queue_draw(GtkWidget $widget)
    is native(&gtk-lib)
    is export
    {*}

sub gtk_widget_get_tooltip_text(GtkWidget $widget)
    is native(&gtk-lib)
    is export
    returns Str
    { * }

sub gtk_widget_set_tooltip_text(GtkWidget $widget, Str $text)
    is native(&gtk-lib)
    is export
    { * }

sub gtk_window_new(int32 $window_type)
    is native(&gtk-lib)
    is export
    returns GtkWidget
    {*}

sub gtk_window_set_title(GtkWidget $w, Str $title)
    is native(&gtk-lib)
    is export
    returns GtkWidget
    {*}

# gtk_widget_ ... }}}

# gtk_container_... {{{
sub gtk_container_add(GtkWidget $container, GtkWidget $widgen)
    is native(&gtk-lib)
    is export
    {*}

sub gtk_container_get_border_width(GtkWidget $container)
    returns int32
    is native(&gtk-lib)
    is export
    {*}

sub gtk_container_set_border_width(GtkWidget $container, int32 $border_width)
    is native(&gtk-lib)
    is export
    {*}

# gtk_container_... }}}

# g_signal... {{{

sub g_signal_connect_wd(GtkWidget $widget, Str $signal,
    &Handler (GtkWidget $h_widget, OpaquePointer $h_data),
    OpaquePointer $data, int32 $connect_flags)
    returns int32
    is native(&gobject-lib)
    is symbol('g_signal_connect_object')
    is export
    { * }

sub g_signal_handler_disconnect(GtkWidget $widget, int32 $handler_id)
    is native(&gobject-lib)
    is export
    { * }

# g_signal... }}}

sub g_idle_add(
        &Handler (OpaquePointer $h_data),
        OpaquePointer $data)
    is native(&glib-lib)
    is export
    returns int32
    {*}

sub g_timeout_add(int32 $interval, &Handler (OpaquePointer $h_data, --> int32), OpaquePointer $data)
    is native(&gtk-lib)
    is export
    returns int32
    {*}

#
# App
#
sub gtk_init(CArray[int32] $argc, CArray[CArray[Str]] $argv)
    is native(&gtk-lib)
    is export(:app)
    {*}

sub gtk_main()
    is native(&gtk-lib)
    is export(:app)
    {*}

sub gtk_main_quit()
    is native(&gtk-lib)
    is export(:app)
    {*}

#
# Box
#
sub gtk_box_pack_start(GtkWidget, GtkWidget, int32, int32, int32)
    is native(&gtk-lib)
    is export(:box)
    {*}

sub gtk_box_get_spacing(GtkWidget $box)
    returns int32
    is native(&gtk-lib)
    is export(:box)
    {*}

sub gtk_box_set_spacing(GtkWidget $box, int32 $spacing)
    is native(&gtk-lib)
    is export(:box)
    {*}

#
# HBox
#
sub gtk_hbox_new(int32, int32)
    is native(&gtk-lib)
    is export(:hbox)
    returns GtkWidget
    {*}

#
# VBox
#
sub gtk_vbox_new(int32, int32)
    is native(&gtk-lib)
    is export(:vbox)
    returns GtkWidget
    {*}

#
# Button
#
sub gtk_button_new_with_label(Str $label)
    is native(&gtk-lib)
    is export(:button)
    returns GtkWidget
    {*}

sub gtk_button_get_label(GtkWidget $widget)
    is native(&gtk-lib)
    is export(:button)
    returns Str
    { * }

sub gtk_button_set_label(GtkWidget $widget, Str $label)
    is native(&gtk-lib)
    is export(:button)
    { * }

#
# CheckButton
#
sub gtk_check_button_new_with_label(Str $label)
    is native(&gtk-lib)
    is export(:check-button)
    returns GtkWidget
    {*}

#
# ToggleButton
#
sub gtk_toggle_button_new_with_label(Str $label)
    is native(&gtk-lib)
    is export(:toggle-button)
    returns GtkWidget
    {*}

sub gtk_toggle_button_get_active(GtkWidget $w)
    is native(&gtk-lib)
    is export(:toggle-button)
    returns int32
    {*}

sub gtk_toggle_button_set_active(GtkWidget $w, int32 $active)
    is native(&gtk-lib)
    is export(:toggle-button)
    returns int32
    {*}

#
# ComboBoxText
#
sub gtk_combo_box_text_new()
    is native(&gtk-lib)
    is export(:combo-box-text)
    returns GtkWidget
    { * }

sub gtk_combo_box_text_new_with_entry()
    is native(&gtk-lib)
    is export(:combo-box-text)
    returns GtkWidget
    { * }

sub gtk_combo_box_text_prepend_text(GtkWidget $widget, Str $text)
    is native(&gtk-lib)
    is export(:combo-box-text)
    { * }

sub gtk_combo_box_text_append_text(GtkWidget $widget, Str $text)
    is native(&gtk-lib)
    is export(:combo-box-text)
    { * }

sub gtk_combo_box_text_insert_text(GtkWidget $widget, int32 $position, Str $text)
    is native(&gtk-lib)
    is export(:combo-box-text)
    { * }

sub gtk_combo_box_set_active(GtkWidget $widget, int32 $index)
    is native(&gtk-lib)
    is export(:combo-box-text)
    { * }

sub gtk_combo_box_text_get_active_text(GtkWidget $widget)
    is native(&gtk-lib)
    is export(:combo-box-text)
    returns Str
    { * }

sub gtk_combo_box_text_remove(GtkWidget $widget, int32 $position)
    is native(&gtk-lib)
    is export(:combo-box-text)
    { * }

sub gtk_combo_box_text_remove_all(GtkWidget $widget)
    is native(&gtk-lib)
    is export(:combo-box-text)
    { * }

#
# Grid
#
sub gtk_grid_new()
    is native(&gtk-lib)
    is export(:grid)
    returns GtkWidget
    {*}

sub gtk_grid_attach(GtkWidget $grid, GtkWidget $child, int32 $x, int32 $y, int32 $w, int32 $h)
    is native(&gtk-lib)
    is export(:grid)
    {*}

#
# Scale
#
sub gtk_scale_new_with_range( int32 $orientation, num64 $min, num64 $max, num64 $step )
    is native(&gtk-lib)
    is export(:scale)
    returns GtkWidget
    {*}

# orientation:
# horizontal = 0
# vertical = 1 , inverts so that big numbers at top.
sub gtk_scale_set_digits( GtkWidget $scale, int32 $digits )
    is native( &gtk-lib)
    is export(:scale)    
    {*}
    
sub gtk_range_get_value( GtkWidget $scale )
    is native(&gtk-lib)
    is export(:scale)    
    returns num64
    {*}
    
sub gtk_range_set_value( GtkWidget $scale, num64 $value )
    is native(&gtk-lib)
    is export(:scale)    
    {*}

sub gtk_range_set_inverted( GtkWidget $scale, Bool $invertOK )
    is native(&gtk-lib)
    is export(:scale)    
    {*}

#
# Separator
#
sub gtk_separator_new(int32 $orientation)
    is native(&gtk-lib)
    is export(:separator)
    returns GtkWidget
    { * }
