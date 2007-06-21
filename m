From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Strange diff behavior?
Date: Thu, 21 Jun 2007 11:31:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211131160.4059@racer.site>
References: <31e9dd080706201802h9dcbffawd82575d09e082155@mail.gmail.com> 
 <Pine.LNX.4.64.0706210212060.4059@racer.site> <1182408458.6159.0.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 12:31:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Jx3-00026Y-41
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 12:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbXFUKbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 06:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbXFUKbn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 06:31:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:60341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750895AbXFUKbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 06:31:43 -0400
Received: (qmail invoked by alias); 21 Jun 2007 10:31:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 21 Jun 2007 12:31:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1FI45kMa1nPr8eeGGN5SioVbhKZB7AV8Udz9aAv
	okVFDXQ1WHpIX5
X-X-Sender: gene099@racer.site
In-Reply-To: <1182408458.6159.0.camel@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50612>

Hi,

On Thu, 21 Jun 2007, Raimund Bauer wrote:

> On Thu, 2007-06-21 at 02:13 +0100, Johannes Schindelin wrote:
> 
> > Just a guess: core.autocrlf=true?
> 
> My guess: apply.whitespace=strip

Much better guess, I guess. Jason?

Ciao,
Dscho
