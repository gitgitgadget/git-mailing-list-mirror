From: Martin Mares <mj@ucw.cz>
Subject: Re: SHA1 hash safety
Date: Sun, 17 Apr 2005 01:18:32 +0200
Message-ID: <20050416231832.GA11444@ucw.cz>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz> <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz> <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu> <20050416151116.GC19099@pasky.ji.cz> <Pine.LNX.4.61.0504161114530.29343@cag.csail.mit.edu> <Pine.LNX.4.62.0504161549410.22652@qynat.qvtvafvgr.pbz> <20050416161153.534b47d5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:15:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwV0-0003OT-0N
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVDPXSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDPXSc
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:18:32 -0400
Received: from albireo.ucw.cz ([84.242.65.67]:26764 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261190AbVDPXSb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:18:31 -0400
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id 758947BD17; Sun, 17 Apr 2005 01:18:32 +0200 (CEST)
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050416161153.534b47d5.pj@sgi.com>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

> We've already computed the chances of a random pure hash collision
> with SHA1 - it's something like an average of 1 collision every
> 10 billion years if we have 10,000 coders generating 1 new file
> version every minute, non-stop, 24 hours a day, 365 days a year.

GIT is safe even for the millions of monkeys writing Shakespeare :-)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Homo homini lupus, frater fratri lupior, bohemus bohemo lupissimus.
