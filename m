From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Thu, 30 Aug 2007 11:08:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708301107320.28586@racer.site>
References: <lkbtwek0.fsf@cante.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 12:08:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQgwl-0000qs-7e
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 12:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbXH3KIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 06:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754994AbXH3KIP
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 06:08:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:53343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754968AbXH3KIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 06:08:14 -0400
Received: (qmail invoked by alias); 30 Aug 2007 10:08:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 30 Aug 2007 12:08:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18D3SNHEIADlZuh/ZMjmIvaQxO0IMkrAtmZlY3OI6
	4XMn1X42iw7e5U
X-X-Sender: gene099@racer.site
In-Reply-To: <lkbtwek0.fsf@cante.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57017>

Hi,

On Thu, 30 Aug 2007, Jari Aalto wrote:

> git-gc is a higher level utility to "do the right thing". However there 
> are many other lower level utilities for the house keeping and it is not 
> clear what git-gc actually does. Adding the actual lower level command 
> and their parameters explain "what's going on".x

Isn't the whole purpose of git-gc to make it _unnecessary_ to know which 
lowlevel commands are run?

NACK.

Ciao,
Dscho
