From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Git tree for old kernels from before the current tree
Date: Tue, 24 Jul 2007 00:46:28 +0100
Message-ID: <20070723234628.GN21668@ftp.linux.org.uk>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com> <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr> <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr> <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr> <46A3D5EA.2050600@zytor.com> <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org> <alpine.LFD.0.999.0707231343350.6355@xanadu.home> <alpine.LFD.0.999.0707231057480.3607@woody.linux-foundation.org> <alpine.LFD.0.999.0707231432560.6355@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:46:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID7c6-0006vt-Qz
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 01:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760931AbXGWXqv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 19:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759259AbXGWXqv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 19:46:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34787 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452AbXGWXqu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 19:46:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1ID7bg-0000NK-CT; Tue, 24 Jul 2007 00:46:28 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707231432560.6355@xanadu.home>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53507>

On Mon, Jul 23, 2007 at 03:06:09PM -0400, Nicolas Pitre wrote:
>  - v0.96 sources
> 
>  - v0.99.12 announcement
> 
>  - sources for v0.99.13{abcdefghij} (got k, don't know where the serie 
>    ends) as well as announcements for all of them
> 
>  - all announcements for v0.99.14{a-z} except for pl14r
> 
>  - announcements for pl15c to pl15j, 1.0-pre1, and ALPHA-1.0.
> 
> Otherwise the archive appears fairly complete with almost 3 years of 
> Linux development history captured in a 3MB pack file.

Umm...  IIRC, tar was unhappy with several tarballs on ftp.kernel.org.
Do you have replacements (or instructions re combination of tar(1) options
to make it eat them)?
