From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 20:38:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602232037260.30630@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se>
 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
 <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
 <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org> <7virr5hnw4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 20:39:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCMIl-0007w5-WA
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 20:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWBWTix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 14:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWBWTix
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 14:38:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:37265 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750719AbWBWTiw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 14:38:52 -0500
Received: (qmail invoked by alias); 23 Feb 2006 19:38:50 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp001) with SMTP; 23 Feb 2006 20:38:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virr5hnw4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16659>

Hi,

On Thu, 23 Feb 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > There are many portable interpreters out there, and I don't mean perl. And 
> > writing a small "specialized for git" one isn't even that hard. In fact, 
> > most of the shell (and bash) hackery we do now would be unnecessary if we 
> > just made a small "git interpreter" that ran "git scripts".
> 
> Before anybody mentions tcl ;-).

Darn, I had my suggestion sent out: Java ;-)

Ciao,
Dscho
