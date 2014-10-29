#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
  my $self = shift;
  $self->render('index');
};

post '/read_text_file' => sub {
  my $self = shift;
  my $file = $self->param('file');

  my $result = "";

  open(my $PS, $file) || return $self->render(text => "Failed to open file!");

  while(<$PS>) {
    $result .= $_;
  };

  $self->render(text => $result);
};

app->start;
app->secrets(['85576461-d478-4c09-ad68-254c87305ce4']);
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<form method="POST" action="/read_text_file">
  <input type="radio" name="file" value="story.txt">Story</input>
  <br/>
  <input type="radio" name="file" value="wip.txt">Work In Progress</input>
  <br/>
  <input type="submit" name="submit" value="submit" />
</form>

@@ response.html.ep
% layout 'default';
% title 'Your results';

<%= results =>
  
@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>


