From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Documentation
Date: Tue, 22 Jul 2008 17:07:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807221705150.8986@racer>
References: <d411cc4a0807212035v68c2ed95m93b77c1e61cfec9e@mail.gmail.com>  <200807220917.57363.johan@herland.net>  <alpine.DEB.1.10.0807220035110.1125@asgard.lang.hm>  <200807221121.22520.johan@herland.net>  <alpine.DEB.1.00.0807221335560.3391@eeepc-johanness>
 <76718490807220847i298f256bm4c3f85bfde079ee2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, david@lang.hm,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLKPL-0001aI-DG
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 18:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbYGVQHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbYGVQHK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:07:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:37167 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752609AbYGVQHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:07:09 -0400
Received: (qmail invoked by alias); 22 Jul 2008 16:07:06 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp001) with SMTP; 22 Jul 2008 18:07:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xQW8kEQHxHXmMJMjF3G0fLP97zEbyO1LHgVT0Jr
	wQ5GjzWPAMse9I
X-X-Sender: gene099@racer
In-Reply-To: <76718490807220847i298f256bm4c3f85bfde079ee2@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89492>

Hi,

On Tue, 22 Jul 2008, Jay Soffian wrote:

> On Tue, Jul 22, 2008 at 7:40 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Most people hate to know the internals.  They buy the car, and never 
> > want to look inside the motor compartment.  They buy wine, and never 
> > want to know how it is made.  They buy an iPod and never want to know 
> > who assembles it, and how, and in what environment.
> 
> I agree with this. And I like the top-down approach. Nonetheless, I 
> think there are a few git concepts that are important to understand. 
> Specifically, I don't think you can use git without understanding the 
> index.

I do not see that the index is an internal.  I see that the term "index" 
is.  So I think about not even bothering to mention it in my first two Git 
lessons.

And you would be surprised to learn that I personally know a few people 
who use Git happily _without_ knowing any internals.  Now guess why: was 
it because I explained a few easy-to-grasp commands, or because I made it 
pretty complicated but thorough?  Exactly.

Ciao,
Dscho
