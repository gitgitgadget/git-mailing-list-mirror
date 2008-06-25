From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: gitwiki/EclipsePlugin
Date: Wed, 25 Jun 2008 20:55:43 +0200
Message-ID: <200806252055.46132.robin.rosenberg.lists@dewire.com>
References: <4862737E.6010502@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: M <mrohrmoser@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBaET-00032m-Re
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbYFYS7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 14:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbYFYS7s
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 14:59:48 -0400
Received: from av10-1-sn2.hy.skanova.net ([81.228.8.181]:60751 "EHLO
	av10-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYFYS7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 14:59:47 -0400
Received: by av10-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id C67D037F0B; Wed, 25 Jun 2008 20:59:45 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av10-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id A0A0637F0B; Wed, 25 Jun 2008 20:59:45 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id CD9CB37E45;
	Wed, 25 Jun 2008 20:59:44 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4862737E.6010502@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86321>

onsdagen den 25 juni 2008 18.34.06 skrev M:
> Hi list,
> I felt quite helpless when trying to get egit running as neither
> http://git.or.cz/gitwiki/EclipsePlugin nor the README/INSTALL aren't
> overly verbose.
> 
> I put the idiot-proof recipe on
> http://wiki.jcurl.org/index.php5?title=GitSvn#Eclipse_Plugin - maybe you
> can weave it into either wiki or INSTALL?

You mean they *are* overly verbose? Our INSTALL has a lot more details
than your wiki, so I'm not sure I understand your problem. 

) 7: uncheck all *.test projects
	not important

) 10: restart eclipse with parameter -clean
	probably a good idea, though I have never needed it

> 
> Greetings,
> 	M

We're going to set up an official update site in the not too distant future.

Cheers,

	-- robin
