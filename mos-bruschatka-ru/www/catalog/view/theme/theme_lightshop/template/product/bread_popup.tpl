				

						<div class="nav-submenu nav-submenu--min">
							<ul class="nav-submenu__list">
								<?php if(isset($breadLists)) { ?>
						<?php foreach ($breadLists as $breadlist) { ?>
							<li class="nav-submenu__list-item"><a href="<?php echo $breadlist['href']; ?>" class="nav-submenu__link"><?php echo $breadlist['name']; ?></a></li>
						<?php }  ?>
								<?php }  ?>
							</ul>
						</div>
