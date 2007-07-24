From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: workflow question
Date: Tue, 24 Jul 2007 22:57:02 +0200
Message-ID: <20070724205702.GD6004@steel.home>
References: <e2a1d0aa0707240653x55dd82b3pf9e3986f5c3bb344@mail.gmail.com> <81b0412b0707240837l16844dbct52ffa426d8b8547b@mail.gmail.com> <e2a1d0aa0707240930gb99cb0csd1ce9946d33982d@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:57:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDRRn-0002eT-B1
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 22:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761502AbXGXU5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 16:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760317AbXGXU5H
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 16:57:07 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:23020 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760259AbXGXU5F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 16:57:05 -0400
Received: from tigra.home (Fa855.f.strato-dslnet.de [195.4.168.85])
	by post.webmailer.de (fruni mo22) (RZmta 10.1)
	with ESMTP id R01096j6OHkg0A ; Tue, 24 Jul 2007 22:57:02 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3D1CD277BD;
	Tue, 24 Jul 2007 22:57:02 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1F426BDD0; Tue, 24 Jul 2007 22:57:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e2a1d0aa0707240930gb99cb0csd1ce9946d33982d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggT2BuA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53644>

Patrick Doyle, Tue, Jul 24, 2007 18:30:12 +0200:
> And, as for gitk, there is something about the combination of the
> screen on my laptop, my Linux installation (FC6), my X server
> configuration, and/or me that makes the fonts totally unreadable.  I
> keep meaning to follow up on that, but I'm stuck in a
> chicken-and-the-egg situation.  I don't see the utility of gitk
> because I can't read the display that it produces.  I don't look for
> the time to fix the display that it produces because, thus far, I
> don't see the utility of gitk.  Sigh...

That's a real pity, because it is very powerful.

Try removing ~/.gitk, or look into it and try changing the font.
Here is mine, for reference:

set mainfont {Helvetica 11}
set textfont {Courier 11}
set uifont {Helvetica 9 bold}
set tabstop 8
set findmergefiles 0
set maxgraphpct 50
set maxwidth 16
set cmitmode patch
set wrapcomment none
set showneartags 1
set showlocalchanges 1
set bgcolor white
set fgcolor black
set colors {green red blue magenta darkgrey brown orange}
set diffcolors {red "#00a000" blue}
set selectbgcolor gray85
set geometry(main) 1005x850+1417+41
set geometry(topwidth) 1001
set geometry(topheight) 458
set geometry(pwsash0) "684 2"
set geometry(pwsash1) "878 2"
set geometry(botwidth) 725
set geometry(botheight) 372
set permviews {}
