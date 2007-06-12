From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git-fetch, was Re: [PATCH] Port git-tag.sh to C.
Date: Tue, 12 Jun 2007 13:41:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706121341250.4059@racer.site>
References: <11813427591137-git-send-email-krh@redhat.com>
 <1b46aba20706081858u7f18d9b2o5602db43d396c19@mail.gmail.com>
 <Pine.LNX.4.64.0706112314300.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carlos Rica <jasampler@gmail.com>,
	=?X-UNKNOWN?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 14:45:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy5kS-0007hM-AK
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 14:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541AbXFLMpQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 08:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756540AbXFLMpQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 08:45:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:45869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756355AbXFLMpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 08:45:13 -0400
Received: (qmail invoked by alias); 12 Jun 2007 12:45:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 12 Jun 2007 14:45:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19abABuYqJaFAJsWjlVcSuEFkfkiW6C0GcJAwn664
	6+ZfUJYmcwdXqy
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706112314300.5848@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49958>

Hi,

On Mon, 11 Jun 2007, Daniel Barkalow wrote:

> On Sat, 9 Jun 2007, Carlos Rica wrote:
> 
> > Feel free to choose the script which you need to get replaced first, 
> > or, depending on your urgency, you could ask me for one of them and I 
> > would try to concentrate my efforts on it. Why do you started with 
> > git-tag? For me, it was enough easy to begin with, perhaps you could 
> > have other reasons.
> 
> Incidentally, I have been working on fetch, based on Julian Phillips's 
> version. I'm trying to split out the "how do I communicate with remote 
> repositories" code, and use it for pushing and ls-remote as well as 
> fetch. I've got a bunch of not-for-official-history development that you 
> should look at if you try any of the remote-repository-access scripts.

How about pushing them onto repo.or.cz as a fork of git.git?

Ciao,
Dscho
