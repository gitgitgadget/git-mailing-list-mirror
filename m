From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Wed, 27 Sep 2006 09:50:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609270948140.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
 <7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu>
 <7vejtxhlv6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262320260.9088@attu4.cs.washington.edu>
 <7vfyedg56m.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609270006020.9602@attu4.cs.washington.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 09:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSUBP-0004R9-0O
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 09:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965442AbWI0HuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 03:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965444AbWI0HuP
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 03:50:15 -0400
Received: from mail.gmx.de ([213.165.64.20]:28104 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965442AbWI0HuN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 03:50:13 -0400
Received: (qmail invoked by alias); 27 Sep 2006 07:50:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 27 Sep 2006 09:50:11 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Rientjes <rientjes@cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0609270006020.9602@attu4.cs.washington.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27887>

Hi,

On Wed, 27 Sep 2006, David Rientjes wrote:

> On Wed, 27 Sep 2006, Junio C Hamano wrote:
> 
> > David Rientjes <rientjes@cs.washington.edu> writes:
> > 
> > > Your argument of saying to yourself "if line_width cannot fit max + len 
> > > then we do this" has no relevance at all.  I can say "if max + len is too 
> > > big for line_width we do this" just the same.
> > 
> > Actually that is exactly my point.  "Just the same".  There is
> > no reason to choose one way or the other from purely logical or
> > mathematical point of view.
> > 
> 
> Nothing about this is "mathematical" at all and I never claimed it was.  
> But there _is_ a reason to choose one way over the other and that is 
> because the MAJORITY of programmers do it one way and YOU do it another 
> way.  Why is it so hard to write all the code in the same style so that 
> there is as little variation in the code as possible?

Could you stop it already?

Git's source code is very clean and readable, even if there are inversions 
you might not be used to.

Besides, always doing it the same way is boring. _Boring_. Or do you make 
love to your girl-friend the same way over and over again?

Ciao,
Dscho
