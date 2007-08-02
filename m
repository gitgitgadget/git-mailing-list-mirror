From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [MinGW PATCH] Fixed error 'fatal: Not a git repository' on Vista
Date: Thu, 2 Aug 2007 11:33:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021107470.14781@racer.site>
References: <DE6EEF3D318C4051827B95DF26D97BE7@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 12:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGY0i-000475-9f
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 12:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbXHBKeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 06:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbXHBKeY
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 06:34:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:57121 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751992AbXHBKeY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 06:34:24 -0400
Received: (qmail invoked by alias); 02 Aug 2007 10:34:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 02 Aug 2007 12:34:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181B/QAsOI1H2/G8oWKTTcpGXBAr8WcdtIb2SGO+A
	VPx6w79dxgCmo9
X-X-Sender: gene099@racer.site
In-Reply-To: <DE6EEF3D318C4051827B95DF26D97BE7@ntdev.corp.microsoft.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54537>

Hi,

[please consider reading Documentation/SubmittingPatches; you did not Cc: 
the maintainer, Johannes Sixt]

On Wed, 1 Aug 2007, Dmitry Kakurin wrote:

> Any git command was immediately failing on Vista under MinGW with
> fatal: Not a git repository

Thanks for submitting this patch.  I cannot test personally, because 
nobody I know has Vista.

I guess that Hannes will apply your patch when he comes back from his 
well-deserved holiday.

You might want to consider pushing your changes to the mob branch on 
repo.or.cz/git/mingw.git.

>From your mail, I take it that the .zip file I sent you is working 
properly?

Ciao,
Dscho
