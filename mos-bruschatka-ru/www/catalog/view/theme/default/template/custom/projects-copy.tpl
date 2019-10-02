<?php echo $header; ?>
<main class="section" id="wrapper">
	<?php if ($content_top) { ?>
		<?php echo $content_top; ?>
	<?php } ?>
	<div class="container">
        <h1 class="main-title"><?php echo $heading_title; ?></h1>
		<div class="grid">
			<?php if($content_left) { ?><aside class="aside aside-left"><?php content_left; ?></aside><?php } ?>
			
			<section class="main-section">
				
			</section>
			
			<?php if($content_right) { ?><aside class="aside aside-right"><?php content_right; ?></aside><?php } ?>
		</div>
	</div><!-- container -->
	<?php if ($content_bottom) { ?>
		<?php echo $content_bottom; ?>
	<?php } ?>
</main>
<?php echo $footer; ?>
</body></html>