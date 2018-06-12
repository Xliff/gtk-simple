use v6.c;

use GTK::Simple::App;
use GTK::Simple::Button;
use GTK::Simple::Container;
use GTK::Simple::Window;

# Create a window
my GTK::Simple::App $app .= new(title => "GTK Focus Test");

my $zero = GTK::Simple::Button.new(label => "Start");
my $first = GTK::Simple::Button.new(label => "First");
my $second = GTK::Simple::Button.new(label => "Second");

$app.set-content( my $vbox = GTK::Simple::VBox.new($first, $second) );

$app.border-width = 20;

$zero.clicked.tap({
  my $t;

  gtk_container_set_focus_child($vbox, $first);
  $t = gtk_container_get_focus($vbox);
  die "'First' Button not set as focus"
    unless $t == $first;
  }

  gtk_container_set_focus_child($vbox, $second);
  $t = gtk_container_get_focus($vbox);
  die "'Second' Button not set as focus"
    unless $t == $second;
  }
});

$app.run;
