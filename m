From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 23 Dec 2006 01:12:24 +0100
Message-ID: <200612230112.24212.Josef.Weidendorfer@gmx.de>
References: <7vzm9g2rv5.fsf@assigned-by-dhcp.cox.net> <200612221111.58071.andyparkins@gmail.com> <7vlkkzv6rq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 01:12:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxuVG-0007xB-CP
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 01:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbWLWAMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 19:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbWLWAMe
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 19:12:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:47710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753312AbWLWAMe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 19:12:34 -0500
Received: (qmail invoked by alias); 23 Dec 2006 00:12:32 -0000
Received: from p5496B9D3.dip0.t-ipconnect.de (EHLO noname) [84.150.185.211]
  by mail.gmx.net (mp018) with SMTP; 23 Dec 2006 01:12:32 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.5
In-Reply-To: <7vlkkzv6rq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35251>

On Saturday 23 December 2006 00:40, you wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > On Friday 2006 December 22 09:37, Junio C Hamano wrote:
> >
> >> * jc/git-add--interactive (Mon Dec 11 17:09:26 2006 -0800) 2 commits
> >>  + git-add --interactive: hunk splitting
> >>  + git-add --interactive
> >
> > I used this to disentangle a load of changes that I made under pressure and 
> > turned them into lovely isolated commits.  I didn't have any trouble with it, 
> > and thought it was incredibly useful.
> >
> > I'd vote for putting it in 1.5 - it's in keeping with the usability theme - 
> > people love interactive stuff.
> 
> Seconds?  Thirds?  Vetoes?

Seconds. I like it.

Andy: Did you check whether your disentangled commits each actually did compile
on their own? If yes, how did you do it?

Josef
