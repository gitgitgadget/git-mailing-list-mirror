From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 22:49:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704192244360.8822@racer.site>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 22:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HedZU-0000ae-It
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 22:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbXDSUtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 16:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbXDSUtV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 16:49:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:35600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965044AbXDSUtU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 16:49:20 -0400
Received: (qmail invoked by alias); 19 Apr 2007 20:49:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 19 Apr 2007 22:49:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Hs+RWhZrH59I0dn5SdoBqxiO4x1oQM9DyKwt70r
	0GC6hbi9vMRA79
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45043>

Hi,

On Thu, 19 Apr 2007, Linus Torvalds wrote:

> On Thu, 19 Apr 2007, Johannes Schindelin wrote:
> 
> You can't *not* mention branches, simply because even people who only 
> track other peoples work do end up often needing to know about it, or at 
> least hearing about them..

Well, there is the classical case of an upstream which never merges from 
you, John R. Developer. You have two branches, upstream and local. But Jim 
R. Developer did not work with Git before, just CVS. To Jim, these are not 
two branches. Still, Git operations are easy, and Jim does not have to 
understand branches to track upstream (keeping local changes).

That is a very valid use scenario, at least from my point of view, since I 
use it quite often.

As an example, for me, "next" is upstream, and I keep some changes local, 
either because Junio refused to merge them, or because they are useful to 
nobody except me.

Of course, these _are_ two branches, but I don't have to realize that when 
working with Git in that manner.

Ciao,
Dscho
