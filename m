From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 11:26:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709071124020.28586@racer.site>
References: <46DDC500.5000606@etek.chalmers.se>  <1189004090.20311.12.camel@hinata.boston.redhat.com>
  <vpq642pkoln.fsf@bauges.imag.fr>  <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
  <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> 
 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> 
 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
 <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
 <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:27:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITb3H-00085G-NL
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 12:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbXIGK05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbXIGK05
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 06:26:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:47449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964853AbXIGK04 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 06:26:56 -0400
Received: (qmail invoked by alias); 07 Sep 2007 10:26:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 07 Sep 2007 12:26:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dsrhrWo1d3otNQPwublgZFuDAhOORoemGmy8rV1
	tWrzDEVc9SVNSX
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58017>

Hi,

On Fri, 7 Sep 2007, Linus Torvalds wrote:

> On Thu, 6 Sep 2007, Dmitry Kakurin wrote:
> 
> > I was pointing out that I've been programming in different languages 
> > (many more actually) and observed bad developers writing bad code in 
> > all of them. So this quality "bad developer" is actually 
> > language-agnostic :-).
> 
> You can write bad code in any language. However, some languages, and 
> especially some *mental* baggages that go with them are bad.

There is an important additional point: a language like C _holds_ you to a 
certain degree of diligence.

In my day-job I have to code in other languages, which make it "easy" to 
code.  As a result, the code I have to work with is sloppy, ugly and 
buggy.  By applying the same principles I am _forced_ to use in C, with 
Git, I produce better code.

Ciao,
Dscho
