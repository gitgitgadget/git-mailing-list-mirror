From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 13:37:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031334530.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGwPd-0008RA-Ca
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 14:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbXHCMhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 08:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbXHCMhq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 08:37:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:41571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751297AbXHCMhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 08:37:46 -0400
Received: (qmail invoked by alias); 03 Aug 2007 12:37:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 03 Aug 2007 14:37:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+O6x4hV4iOl4GzBlDJ4znfzEQcOLgcBZlbo++np6
	qXTp5ad2uMbUst
X-X-Sender: gene099@racer.site
In-Reply-To: <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54714>

Hi,

On Fri, 3 Aug 2007, Dmitry Kakurin wrote:

> The changes that I've made:
> * removed .git in /git directory to save space
> * installed gdb
> * applied my Vista fix
> * made self-extracting .rar archive

* replace rxvt by that stupid cmd window

Sneaky.

Can you defend the choice?

FWIW here are my arguments for rxvt:

	- it behaves the same on all Windows versions
	- it has a scroll back (which you have to activate on cmd first)
	- it is resizable
	- it has sane copy&paste behaviour (which you have to activate on 
		cmd first, and then still have to hit the Return key after 
		having selected some text)

Ciao,
Dscho
