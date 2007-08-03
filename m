From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 22:21:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708032218510.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <46B32C8D.4060804@trolltech.com>  <Pine.LNX.4.64.0708031434130.14781@racer.site>
  <46B34B0D.6030106@trolltech.com>  <Pine.LNX.4.64.0708031649480.14781@racer.site>
  <46B36B7F.8010008@trolltech.com>  <fd2562310708031133m72b43265n35277c360ef2ca7a@mail.gmail.com>
  <46B3764E.6090106@trolltech.com>  <Pine.LNX.4.64.0708031954480.14781@racer.site>
  <46B37B09.1030808@trolltech.com> <fd2562310708031213sabc4599m79166f52e78edde3@mail.gmail.com>
 <Pine.LNX.4.64.0708032027250.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Mike Pape <dotzenlabs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 23:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH4as-0002mv-Dh
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 23:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761792AbXHCVV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 17:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761970AbXHCVV4
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 17:21:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:46726 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761792AbXHCVVz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 17:21:55 -0400
Received: (qmail invoked by alias); 03 Aug 2007 21:21:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 03 Aug 2007 23:21:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RlqRIxL8RbkABaYtqdk1CkBPJJZDb837E/e6fAs
	n2TfWgNlgmEKo4
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0708032027250.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54759>

Hi,

On Fri, 3 Aug 2007, Johannes Schindelin wrote:

> Okay, I am really close to initialising the repository on
> 
> 	http://repo.or.cz/w/git/mingw/msysgit.git

Actually, that did not work out too well.  It is not really a fork, so the 
tags all pointed nowhere, and I could not even upload origin/devel to fix 
that.  So I bit the apple and initialised a new repo:

	http://repo.or.cz/w/msysgit.git

This will be the official repo for this project.

All users who sent me their username are already registered there.

Ciao,
Dscho
