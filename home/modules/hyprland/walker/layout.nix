{
	ui = {
		anchors = {
			bottom = true;
			left = true;
			right = true;
			top = true;
		};

		window = {
			h_align = "fill";
			v_align = "fill";

			box = {
				h_align = "center";
				width = 450;
				margins.top = 200;

				bar = {
					orientation = "horizontal";
					position = "end";
				};

				scroll.list = {
					item.icon.pixel_size = 24;
					margins.top = 8;

					max_height = 300;
					max_width = 400;
					min_width = 400;
					width = 400;
				};

				search.input = {
					h_align = "fill";
					h_expand = true;
					icons = true;
				};
			};
		};
	};
}
