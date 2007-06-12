From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Watchpoints
Date: Tue, 12 Jun 2007 15:21:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706121514280.4059@racer.site>
References: <19f34abd0706120651m2cfab331te0976eddb479b88c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 16:25:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy7JA-0005p0-1t
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 16:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbXFLOZM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 10:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbXFLOZM
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 10:25:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:47761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752111AbXFLOZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 10:25:11 -0400
Received: (qmail invoked by alias); 12 Jun 2007 14:25:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 12 Jun 2007 16:25:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VZhcyKPtVllF0K5XIdg7BPHt1HPmwKUbp9ci0AZ
	kab19afOSn1BOz
X-X-Sender: gene099@racer.site
In-Reply-To: <19f34abd0706120651m2cfab331te0976eddb479b88c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49965>

Hi,

On Tue, 12 Jun 2007, Vegard Nossum wrote:

> A lot of kernel developers consider purely-syntactic changes (ie. fixing 
> whitespace issues) to be noisy/disruptive. Therefore, even when such 
> changes are for the better (according to the coding style, etc), they do 
> not usually make it to the "mainline".

FWIW I don't think that there are that many developers who think 
whitespace fixes are useless. For example, Git recently saw a small series 
which did nothing _except_ white space fixes.

And I can see the value of it. Just take your home as an example. You are 
used to a certain order of things there. I, for one, have a routine where 
I go when coming home, and where I expect my wine bottle to be. If that 
bottle is somewhere else, I have to find it first. It's just a tiny itch, 
but a real one.

The same applies to source code: when I am hacking on Git, I expect things 
in a certain layout, and find my way easily through that. If there are 
some things I am not used to (yes, even a missing space after an "if"), it 
takes away my attention briefly from what I want to do. It's just a tiny 
itch, but a real one.

If tiny itches add up, they become larger ones. And soon you have a real 
problem.

So, if somebody tells you that code style does not matter, ignore her. She 
has no clue about how people tick, really.

Ciao,
Dscho
