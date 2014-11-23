cnt=$(cat)
echo '<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1024" />
		<meta name="apple-mobile-web-app-capable" content="yes" />';
titl=$(echo "$cnt" | bash scrape.sh -t)
echo "		<title>$titl</title>"
desc=$(echo "$cnt" | bash scrape.sh -D)
echo "		<meta name=\"description\" content=\"$desc\"/>"
auth=$(echo "$cnt" | bash scrape.sh -a)
date=$(echo "$cnt" | bash scrape.sh -d)
echo "		<meta name=\"author\" content=\"$auth\"/>"
echo '		<link href="http://fonts.googleapis.com/css?family=Open+Sans:regular,semibold,italic,italicsemibold|PT+Sans:400,700,400italic,700italic|PT+Serif:400,700,400italic,700italic" rel="stylesheet" />';
echo '<link href="impress.js/css/impress-demo.css" rel="stylesheet" />'
echo '	</head>
	<body>
		<div class="fallback-message">
			<p>Your browser <b>does not support the features required</b> by impress.js, so you are presented with a simplified version of this presentation.</p>
			<p>For the best experience please use the latest <b>Chrome</b>, <b>Safari</b> or <b>Firefox</b> browser.</p>
		</div>
		<div id="impress">
			<div id="title" class="step" data-x="0" data-y="0" data-scale="4">';
#				<span class="try">then you should try</span>
echo "					<h1><center>$titl</center></h1>"
echo "				<span><center>$date</center></span>"
echo "				<span>By $auth</span>"
echo '			</div>
		</div>'
echo '	</body>
</html>'
