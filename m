X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 11:51:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141147200.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612140116430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612141021.12637.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 10:51:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612141021.12637.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34310>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuoBJ-0000ei-4c for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932413AbWLNKvI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWLNKvH
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:51:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:36039 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932447AbWLNKvE
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 05:51:04 -0500
Received: (qmail invoked by alias); 14 Dec 2006 10:51:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp001) with SMTP; 14 Dec 2006 11:51:03 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Andy Parkins wrote:

> On Thursday 2006 December 14 00:22, Johannes Schindelin wrote:
> 
> > >  * git-revert should be called git-invert.  It doesn't remove a change
> > >    from history, it simply applies another commit that does the
> > >    opposite of whatever commit you are "revert"ing.  That's an inversion.
> >
> > No. An inversion is the _opposite_. Not an undo.
> 
> That's what I'm saying, we are applying the opposite of the given commit 
> - that commit is being inverted and applied again.

Ahh! I get what you are thinking. I was talking about reverting a change 
from the _content's viewpoint_. I _never_ want to revert history (I am no 
politician, you know?)

> > newbie cannot, and does not want to, understand exactly what is going 
> > on.
> 
> "newbie" doesn't mean "idiot".  Everybody wants to understand what is 
> going on.

I heartly disagree. I saw so many faces _begging_ me to just say _what_ to 
do, not _why_, and quickly, please.

> > So, think of it as our response to Windows' non-progress-bar: when you 
> > start up Windows, there is a progress-bar, except that it does not 
> > show progress, but a Knight Rider like movement, only indicating that 
> > it does something.
> 
> Given the choice between nothing and a non-progress "doing something" 
> bar, I would of course pick the "doing something" bar.  However, given 
> the choice between a "doing something" bar and a progress bar, I'd 
> rather have the progress bar.

If I have the choice between a "doing something" bar and a Windows 
Explorer "14 seconds left" bar showing the same message for two minutes, 
I'd rather have a Mars bar ;-)

Ciao,
Dscho
