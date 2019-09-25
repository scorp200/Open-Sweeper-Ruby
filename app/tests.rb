$gtk.reset 100
$gtk.suppress_framerate_warning = true
def test_bomb args, assert
	args.state.tick_count = 0
	tick args
	puts args.state.tick_count, args.state.tiles[12 * 20 + 4].to_s, "hello"
	$gtk.console.show
end

$gtk.tests.start