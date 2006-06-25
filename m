From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Mon, 26 Jun 2006 01:23:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606260121040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
 <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
 <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
 <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <20060625012435.GZ21864@pasky.or.cz>
 <7vfyhtopjm.fsf@assigned-by-dhcp.cox.net> <20060625093444.GD21864@pasky.or.cz>
 <Pine.LNX.4.63.0606251202320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060625102037.GI29364@pasky.or.cz> <7vzmg1v7ci.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606251537450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <86veqp8456.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jun 26 01:23:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fudx4-0001xt-88
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 01:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965654AbWFYXX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 19:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965655AbWFYXX0
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 19:23:26 -0400
Received: from mail.gmx.net ([213.165.64.21]:18844 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965654AbWFYXX0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 19:23:26 -0400
Received: (qmail invoked by alias); 25 Jun 2006 23:23:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 26 Jun 2006 01:23:24 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86veqp8456.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22647>

Hi,

On Sun, 25 Jun 2006, Randal L. Schwartz wrote:

> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> Johannes> Perl, Python and sometimes even bash are good for fast
> Johannes> prototyping. But for serious work, such as profiling, they are not
> Johannes> that good.
> 
> Allow my to register my strong disagreement to that statement, but then I'll
> crawl back in my hole.

Which statement do you mean? The "good for fast prototyping" one? ;-)

Being our friendly local Perl wizard, who could code cvsserver as a Perl 
one-liner, you probably want to say that profiling Perl is easy. Can you 
enlighten me how to do memory _and_ timing profiling on, say, a per-line 
basis?

Ciao,
Dscho
