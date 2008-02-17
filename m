From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Sun, 17 Feb 2008 19:36:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802171935200.30505@racer.site>
References: <alpine.LNX.1.00.0802171337000.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQpJy-0006UI-KD
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbYBQTgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbYBQTgb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:36:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:42900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751768AbYBQTgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:36:31 -0500
Received: (qmail invoked by alias); 17 Feb 2008 19:36:28 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp021) with SMTP; 17 Feb 2008 20:36:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lu9gdy7ilmy9D5dMrTM89LqujXaXsIHqPxWN9cT
	Nw9zAUkEqHfHQD
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802171337000.5816@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74172>

Hi,

On Sun, 17 Feb 2008, Daniel Barkalow wrote:

> This allows users with different preferences for access methods to the 
> same remote repositories to rewrite each other's URLs by pattern 
> matching across a large set of similiarly set up repositories to each 
> get the desired access.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

How about adding your example with master.kernel.org?  That should make it 
easier to understand for people like me, who was puzzled after reading 
this commit message the first time.

Ciao,
Dscho
