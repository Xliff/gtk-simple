use v6.c;

use NativeCall;

use GTK::Simple::App;
use GTK::Simple::Button;
use GTK::Simple::Container;
use GTK::Simple::Raw;
use GTK::Simple::VBox;
use GTK::Simple::Window;

# Create a window
my GTK::Simple::App $app .= new(title => "GTK Window Resizeable Test");

my $zero   = GTK::Simple::Button.new(label => "Start");

$app.set-content( my $vbox = GTK::Simple::VBox.new($zero) );
$app.border-width = 20;

$zero.clicked.tap({
  $app.resizeable = 0;
  say "OK" unless $app.resizeable;
});

$app.run;
