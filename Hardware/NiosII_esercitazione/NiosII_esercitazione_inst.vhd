	component NiosII_esercitazione is
		port (
			clk_clk            : in  std_logic                     := 'X';             -- clk
			hex3_hex0_export   : out std_logic_vector(7 downto 0);                     -- export
			hex5_hex4_export   : out std_logic_vector(31 downto 0);                    -- export
			leds_export        : out std_logic_vector(9 downto 0);                     -- export
			push_button_export : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			reset_reset_n      : in  std_logic                     := 'X';             -- reset_n
			sliders_export     : in  std_logic_vector(9 downto 0)  := (others => 'X')  -- export
		);
	end component NiosII_esercitazione;

	u0 : component NiosII_esercitazione
		port map (
			clk_clk            => CONNECTED_TO_clk_clk,            --         clk.clk
			hex3_hex0_export   => CONNECTED_TO_hex3_hex0_export,   --   hex3_hex0.export
			hex5_hex4_export   => CONNECTED_TO_hex5_hex4_export,   --   hex5_hex4.export
			leds_export        => CONNECTED_TO_leds_export,        --        leds.export
			push_button_export => CONNECTED_TO_push_button_export, -- push_button.export
			reset_reset_n      => CONNECTED_TO_reset_reset_n,      --       reset.reset_n
			sliders_export     => CONNECTED_TO_sliders_export      --     sliders.export
		);

