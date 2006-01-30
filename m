From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [Census] So who uses git?
Date: Mon, 30 Jan 2006 23:51:07 +0100
Message-ID: <20060130225107.GA3857@limbo.home>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>, Junio C Hamano <junkio@cox.net>,
	cworth@cworth.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 22:00:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F42bQ-0003Y6-9B
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 21:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWAaU7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 15:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWAaU7t
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 15:59:49 -0500
Received: from devrace.com ([198.63.210.113]:11279 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751484AbWAaU7s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 15:59:48 -0500
Received: from tigra.home (p54A07FD9.dip.t-dialin.net [84.160.127.217])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0VKxKYs078017;
	Tue, 31 Jan 2006 14:59:21 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from [192.168.1.24] (helo=limbo.home ident=200)
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F42ap-0003vg-00; Tue, 31 Jan 2006 21:59:15 +0100
Received: by limbo.home (Postfix, from userid 1000)
	id D360BEC417; Mon, 30 Jan 2006 23:51:08 +0100 (CET)
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Content-Disposition: inline
In-Reply-To: <43DCA495.9040301@gorzow.mm.pl>
User-Agent: Mutt/1.4.2.1i
X-Spam-Status: No, score=0.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL 
	autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15346>

Radoslaw Szkodzinski, Sun, Jan 29, 2006 12:18:45 +0100:
> > Fortunately, there are very few people involved with any specific piece
> > of the X.org distribution; there's really only one or two people
> > actively developing the X.org core server, so that part of the migration
> > will be easy. Our users will be stuck, but there aren't many of them
> > either, and git makes just sucking the current bits pretty easy. 
> 
> Not under Windows (bleh), but it's support for Cygwin is getting better
> and better.
> 

I use git in cygwin for a project with more then 17k files (almost 6M lines).
It's real slow on ntfs (on 3.2Mhz PIV!), PITA on fat, and has some hiccups now
and then (of the kind: "windows unexpectedly does not have feature X, which
everything else has" or "windows broke a 20-year-old feature Y").

But its more intuitive and more powerful than any alternatives here (Perforce,
SVN and CVS come to mind).
