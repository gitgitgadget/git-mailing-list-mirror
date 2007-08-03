From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 22:32:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708032231320.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
 <Pine.LNX.4.64.0708031334530.14781@racer.site>
 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 23:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH4m6-0006Si-LD
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 23:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762352AbXHCVdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 17:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764093AbXHCVdF
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 17:33:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:33939 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762037AbXHCVdC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 17:33:02 -0400
Received: (qmail invoked by alias); 03 Aug 2007 21:33:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 03 Aug 2007 23:33:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qwuVfECgqtrhqcz8MVXzuYFi0yjGqr1KbWfW5Bm
	QonEcUOJ5lrKkM
X-X-Sender: gene099@racer.site
In-Reply-To: <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54762>

Hi,

On Fri, 3 Aug 2007, Dmitry Kakurin wrote:

> > * replace rxvt by that stupid cmd window
> > Sneaky.
> 
> This was a result of my customization that I have forgot to remove.
> In general cmd window is more familiar/convenient for Windows users.
> IMHO, our goal here should be "as native (Windows) as possible". Cygwin fills
> "as close to *nix as possible" niche.
> But in any case it's such a minor detail that I don't really care much.

Actually, I finally saw the light and implemented your idea of the 
repo.or.cz repository, containing a full copy of the darn beast.

And there, differences like this one are much easier to spot.

Besides, Marius convinced me already to include two versions.

Ciao,
Dscho
