From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: There you have it. Git.pm breaks pull.
Date: Mon, 3 Jul 2006 10:39:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607031039110.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607030633120.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ifuwo7.fsf@assigned-by-dhcp.cox.net> <7v1wt3uvvq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 03 10:39:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxJyB-00017k-GS
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 10:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWGCIjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 04:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWGCIjs
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 04:39:48 -0400
Received: from mail.gmx.net ([213.165.64.21]:5574 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750933AbWGCIjs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 04:39:48 -0400
Received: (qmail invoked by alias); 03 Jul 2006 08:39:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 03 Jul 2006 10:39:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wt3uvvq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23166>

Hi,

On Sun, 2 Jul 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> Can't locate Git.pm in @INC (@INC contains: 
> >> /home/gene099/lib/perl5/site_perl/5.8.0/i586-linux-thread-multi 
> >>...
> >
> >         PERL5LIB=`pwd`/perl/blib/lib:`pwd`/perl/blib/arch/auto/Git
> >         export PERL5LIB
> 
> ... and I tested the above -- it works fine.

Thank you. It works fine, here, too.

Ciao,
Dscho
