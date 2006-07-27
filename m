From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 23:06:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607272254370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060727195614.7EDAE353B04@atlas.denx.de>
 <Pine.LNX.4.63.0607272239050.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060727205158.GE13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wolfgang Denk <wd@denx.de>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 23:06:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6D3o-0001Al-Bm
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWG0VGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWG0VGN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:06:13 -0400
Received: from mail.gmx.de ([213.165.64.21]:49317 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751209AbWG0VGJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 17:06:09 -0400
Received: (qmail invoked by alias); 27 Jul 2006 21:06:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 27 Jul 2006 23:06:08 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060727205158.GE13776@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24343>

Hi,

On Thu, 27 Jul 2006, Petr Baudis wrote:

> Dear diary, on Thu, Jul 27, 2006 at 10:39:55PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > >From a standpoint of copyright (which the GPL relies on), this is not 
> > possible: you cannot include C code into Java. And if it is _translated_ 
> > from C into Java, it is not copyrighted any more.
> 
>   now that's a pretty strong statement - did a lawyer tell you that?

<politics>
No. And I hate the fact that more and more people are actually accepting 
the idea of being dictated how they should live by lawyers.

If a law is not clear to a layman, it should not be enforcable.
</politics>

> (Lawyer in what country? Germany?) Because copyrights are generally
> retained over translations, otherwise I could freely publish
> e.g. Czech translation of someone else's English book without any
> permissions and such, which is obviously not the case.

<message="I am not a lawyer... sh1t, I am disgusted by those">
The bigger problem is to _prove_ that it is a translation. It is much 
easier with a 300-page book you translated from English into Czech.

It is almost impossible to prove something was copied if the source 
language is a procedural computer language, and the target language is an 
object-oriented computer language. Given the technical abilities of 
judges, I even doubt that the act of the translation would _not_ be deemed 
a non-literal transformation of the source code (and thus not be a 
copyright case).
</message>

>   There has been actually similar issue with OpenTTD - it was created by
> translating Transport Tycoon Deluxe assembly to C without permission of
> original TTD copyright owner (not that anyone actually knows for sure
> who that is, after series of company mergers and buyouts). I don't think
> anyone consulted a lawyer about legality of that either but I believe
> that most people agree that this is basically illegal (but most likely,
> noone will ever sue, or care at all).

<politics again=true>
Let's be honest: lawyers will only be interested in the money they get. 
They will not care one wit about what is right or wrong: just look in some 
newspaper of your choice. This is a sad fact about our world (but there is 
a remedy: look into the Hitchhiker's guide to the galaxy).

The consequence is: no lawyer will properly defend the work of open source 
people, since they tend to be poor (well, at least not rich). You just 
cannot make much money by being nice.
</politics>

Ciao,
Dscho
