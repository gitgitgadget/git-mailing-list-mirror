From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: Fri, 24 Feb 2006 22:48:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602242246430.11479@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
 <87k6bxvmj6.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
 <87fymlvgzv.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141224110.3691@g5.osdl.org>
 <87d5hpvc8p.wl%cworth@cworth.org> <7vu0b1pntl.fsf@assigned-by-dhcp.cox.net>
 <87zmkhrf4y.wl%cworth@cworth.org> <43FED93D.1000601@op5.se>
 <87oe0wrg29.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:49:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCkoC-0008Fs-Hs
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 22:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWBXVst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWBXVst
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 16:48:49 -0500
Received: from mail.gmx.de ([213.165.64.20]:61059 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932577AbWBXVss (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 16:48:48 -0500
Received: (qmail invoked by alias); 24 Feb 2006 21:48:47 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp033) with SMTP; 24 Feb 2006 22:48:47 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87oe0wrg29.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16743>

Hi,

On Fri, 24 Feb 2006, Carl Worth wrote:

> On Fri, 24 Feb 2006 11:00:29 +0100, Andreas Ericsson wrote:
> > 
> > I've said it before, and I'll say it again. This tool provides less 
> > flexibility and much less power than "git checkout -b branch 
> > <commit-ish>"
> 
> Yes, that's by design. It's not intended to be a replacement for git
> checkout -b.

I do not really understand why.

git-seek shares so many characteristics with git-seek, you could make 
git-seek just another command line option to checkout (like "--temporary" 
and "--go-back").

Hth,
Dscho
