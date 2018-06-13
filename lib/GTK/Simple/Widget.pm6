
use v6;

use NativeCall;
use GTK::Simple::Common;
use GTK::Simple::GDK;
use GTK::Simple::Raw;

unit role GTK::Simple::Widget;

has $!gtk_widget;
has $!deleted_supply;

multi method WIDGET() {
    $!gtk_widget;
}

multi method WIDGET($gtk-widget) {
    $!gtk_widget = $gtk-widget;
}

method WINDOW() {
    my $result = gtk_widget_get_window($!gtk_widget);
    $result;
}

# method grab-focus
#   is aka<grab_focus>
# {
#   gtk_widget_grab_focus($!gtk_widget);
# }
#
# method has-focus
#   is aka<is-focus>
#   is aka<has_focus>
# {
#   ( gtk_widget_is_focus($!gtk_widget) ).Bool;
# }

method sensitive()
    returns Bool
    is gtk-property(&gtk_widget_get_sensitive, &gtk_widget_set_sensitive)
    { * }

method tooltip-text()
    returns Str
    is gtk-property(&gtk_widget_get_tooltip_text, &gtk_widget_set_tooltip_text)
    { * }

method no-show-all()
    returns Bool
    is gtk-property(&gtk_widget_get_no_show_all, &gtk_widget_set_no_show_all)
    { * }

method events {
    my $window = self.WINDOW;
    my class GdkEventMaskWrapper {
        method set(*@events) {
            my $mask = gdk_window_get_events($window);
            $mask +|= [+|] @events;
            gdk_window_set_events($window, $mask)
        }
        method get {
            my int32 $mask = gdk_window_get_events($window);
            return do for EVENT_MASK::.values {
                if $mask +& +$_ {
                    $_
                }
            }
        }
        method clear {
            gdk_window_set_events($window, 0);
        }
    }
    GdkEventMaskWrapper.new
}

method has-focus {
  #gtk_container_get_focus_child(self.WIDGET) === $widget.WIDGET;
  ( gtk_widget_is_focus(self.WIDGET) ).Bool;
}

method grab-focus {
  gtk_widget_grab_focus(self.WIDGET);
}

method signal-supply(Str $name) {
    my $s = Supplier.new;
    g_signal_connect_wd($!gtk_widget, $name,
        -> $widget, $event {
            $s.emit(($widget, $event));
            CATCH { default { note "in signal supply for $name:"; note $_; } }
        },
        OpaquePointer, 0);
    $s.Supply;
}

method signal_supply(Str $name)
  #is DEPRECATED('signal-supply',Any,'0.3.2');
  is DEPRECATED('signal-supply')
{
    self.signal-supply($name);
}

method size-request(Cool $width, Cool $height) {
    gtk_widget_set_size_request($!gtk_widget, $width.Int, $height.Int);
}

method size_request(Cool $width, Cool $height)
  #is DEPRECATED('size-request',Any,'0.3.2')
  is DEPRECATED('size-request')
{
    self.size-request($width, $height);
}

method width() {
    gtk_widget_get_allocated_width($!gtk_widget);
}
method height() {
    gtk_widget_get_allocated_height($!gtk_widget);
}

method queue-draw() {
    gtk_widget_queue_draw($!gtk_widget);
}

method queue_draw()
  #is DEPRECATED('queue-draw',Any,'0.3.2')
  is DEPRECATED('queue-draw')
{
    self.queue-draw();
}

method destroy() {
    gtk_widget_destroy($!gtk_widget);
}

method show() {
    gtk_widget_show($!gtk_widget);
}

method hide() {
    gtk_widget_hide($!gtk_widget);
}

# All widgets get the 'delete-event'
#| Tap this supply to react to the window being closed
method deleted() {
    $!deleted_supply //= do {
        my $s = Supplier.new;
        g_signal_connect_wd($!gtk_widget, "delete-event",
            -> $, $ {
                $s.emit(self);
                CATCH { default { note $_; } }
            },
            OpaquePointer, 0);
        $s.Supply;
    }
}

method show-all() {
    gtk_widget_show_all($!gtk_widget);
}
