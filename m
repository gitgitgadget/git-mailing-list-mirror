From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 14:13:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121412410.4362@racer.site>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 15:13:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ira2z-0003Kk-NU
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 15:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbXKLONh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 09:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbXKLONh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 09:13:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:44751 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752573AbXKLONg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 09:13:36 -0500
Received: (qmail invoked by alias); 12 Nov 2007 14:13:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 12 Nov 2007 15:13:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hSC1fRf9hEFVnf44RCQVb+zzhMcn49/aTDmad69
	J5Ot8GdejwVERo
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64623>

Hi,

On Mon, 12 Nov 2007, Jon Smirl wrote:

> I'd like to do this sequence, but I can't figure out how without editing 
> the config file. There doesn't seem to be a simple command to move the 
> origin.
> 
> git clone linus
> move origin to digispeaker.git

AKA "git config remote.origin.url <your-digispeaker-url-here>"

> git pull

Hth,
Dscho
