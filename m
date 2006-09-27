From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Wed, 27 Sep 2006 10:35:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609271030180.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
 <7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu>
 <7vejtxhlv6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262320260.9088@attu4.cs.washington.edu>
 <7vfyedg56m.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609270006020.9602@attu4.cs.washington.edu>
 <Pine.LNX.4.63.0609270948140.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP024D1DA4730F9DF93F857FAE1A0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Rientjes <rientjes@cs.washington.edu>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 10:35:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSUtE-0005wq-Dq
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 10:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWI0IfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 04:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965438AbWI0IfU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 04:35:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:7071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964805AbWI0IfT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 04:35:19 -0400
Received: (qmail invoked by alias); 27 Sep 2006 08:35:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 27 Sep 2006 10:35:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP024D1DA4730F9DF93F857FAE1A0@CEZ.ICE>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27890>

Hi,

On Wed, 27 Sep 2006, Sean wrote:

> On Wed, 27 Sep 2006 09:50:11 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > Could you stop it already?
> 
> Well i'd like to offer some support for David.
> 
> In English you'd never say "if 10 is less than the number of girls"
> you'd always say "if the number of girls is greater than 10".
> 
> Why on earth would you ever write C code different than the way you'd
> express the same question in natural language?   Maybe this is only common
> in English and other languages are different; that would explain why this
> seems more natural to some.

In this case, though, "English" is utterly, totally irrelevant. The 
question is a mathematical one, and thus, the solution is a mathematical 
one.

So, in essence, if you do not understand a conditional with a constant on 
the left side, just because it happens to honour the mathematical view of 
"left is small, right is large", you do not stand a chance of 
understanding the formula, right?

> > Git's source code is very clean and readable, even if there are inversions 
> > you might not be used to.
> 
> Not to me.  I find it very annoying to have to figure out what
> "if ( 10 < x ) ..." is really trying to do.

Oh, come on! You cannot possibly spend even _seconds_ on this particular 
construct!

'nough said.

Ciao,
Dscho
