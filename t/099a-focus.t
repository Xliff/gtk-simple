use v6.c;

use NativeCall;

use GTK::Simple::App;
use GTK::Simple::Button;
use GTK::Simple::Container;
use GTK::Simple::Raw;
use GTK::Simple::VBox;
use GTK::Simple::Window;

# Create a window
my GTK::Simple::App $app .= new(title => "GTK Focus Test");

my $zero   = GTK::Simple::Button.new(label => "Start");
my $first  = GTK::Simple::Button.new(label => "First");
my $second = GTK::Simple::Button.new(label => "Second");

$app.set-content(
  my $vbox = GTK::Simple::VBox.new(
    $zero, $first, $second
  )
);

$app.border-width = 20;
$zero.clicked.tap({
  $first.grab-focus;
  die "'First' Button not set as focus"  unless  $first.has-focus;

  $second.grab-focus;
  die "'Second' Button not set as focus" unless $second.has-focus;

  $app.exit;
});

$app.run;
