From: Olivier Andrieu <oandrieu@nerim.net>
Subject: Re: git-viz tool for visualising commit trees
Date: Wed, 20 Apr 2005 22:00:44 +0200 (CEST)
Message-ID: <20050420.220044.74738862.oandrieu@nerim.net>
References: <20050417194818.GG1461@pasky.ji.cz>
	<20050420100824.GB25477@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 21:57:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOLJQ-0002Om-Pj
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 21:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVDTUAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 16:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVDTUAy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 16:00:54 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:51205 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261773AbVDTUAr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 16:00:47 -0400
Received: from localhost (karryall.dnsalias.org [62.4.18.180])
	by kraid.nerim.net (Postfix) with ESMTP
	id AB2FD41CF3; Wed, 20 Apr 2005 22:00:44 +0200 (CEST)
To: mingo@elte.hu
In-Reply-To: <20050420100824.GB25477@elte.hu>
X-Mailer: Mew version 4.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 > Ingo Molnar <mingo@elte.hu> [Wed, 20 Apr 2005]:
 > 
 > * Petr Baudis <pasky@ucw.cz> wrote:
 > 
 > >   Hi,
 > > 
 > >   just FYI, Olivier Andrieu was kind enough to port his monotone-viz 
 > > tool to git (http://oandrieu.nerim.net/monotone-viz/ - use the one 
 > > from the monotone repository). The tool visualizes the history flow 
 > > nicely; see
 > > 
 > > 	http://rover.dkm.cz/~pasky/gitviz1.png
 > > 	http://rover.dkm.cz/~pasky/gitviz2.png
 > > 	http://rover.dkm.cz/~pasky/gitviz3.png
 > > 	http://rover.dkm.cz/~pasky/gitviz4.png
 > > 	http://rover.dkm.cz/~pasky/gitviz5.png
 > > 	http://rover.dkm.cz/~pasky/gitviz6.png
 > > 	http://rover.dkm.cz/~pasky/gitviz7.png
 > > 
 > > for some screenshots.
 > 
 > really nice stuff! Any plans to include it in git-pasky, via 'git gui' 
 > option or so? Also, which particular version has this included - the 
 > freshest tarball on the monotone-viz download site doesnt seem to 
 > include it.

I'll post a tarball soon. You can also get it from the monotone
repository, but I wouldn't recommend it unless you want to try
monotone as well : that involves a rather large download.

-- 
   Olivier
