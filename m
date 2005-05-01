From: bert hubert <ahu@ds9a.nl>
Subject: Re: Quick command reference
Date: Sun, 1 May 2005 23:18:08 +0200
Message-ID: <20050501211808.GA6900@outpost.ds9a.nl>
References: <17012.53862.704670.858276@cargo.ozlabs.ibm.com> <4274EB3D.2060602@dgreaves.com> <4274F373.6030001@khandalf.com> <4274FB3F.8090206@dgreaves.com> <Pine.LNX.4.58.0505010927040.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greaves <david@dgreaves.com>, omb@bluewin.ch,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 23:38:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSM8O-0002Ck-NX
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVEAVmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVEAVZM
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:25:12 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36273 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262691AbVEAVXd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 17:23:33 -0400
Received: by outpost.ds9a.nl (Postfix, from userid 1000)
	id 8E2D63F6F; Sun,  1 May 2005 23:18:08 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505010927040.2296@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 01, 2005 at 09:29:23AM -0700, Linus Torvalds wrote:
> (And no, by "standard format" I do _not_ mean xml or stuff like that. I 
> mean something that is actually easy to read ;)

I've recently been very happy with AsciiDoc
http://www.methods.co.nz/asciidoc/ - it's input is as easy to read as to
write.

>From this input:
http://ds9a.nl/splitpipe/splitpipe-0.3/doc/splitpipe.1.txt

It produces this lovely page (html, man, pdf, the works):
http://ds9a.nl/splitpipe/splitpipe-0.3/doc/splitpipe.1.html

And if you are really in a wild mood, you can have it make entire websites,
like http://ds9a.nl/splitpipe

When used properly it builds tables of contents, indexes, books and whatnot.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
