From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 14:52:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171452030.28586@racer.site>
References: <11900314321506-git-send-email-hjemli@gmail.com> <46EE7584.8010202@op5.se>
 <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com>
 <Pine.LNX.4.64.0709171422340.28586@racer.site> <20070917133742.GA10923@pe.Belkin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:53:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXH2X-0001nd-6o
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbXIQNxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 09:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbXIQNxZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:53:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:36496 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753715AbXIQNxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 09:53:24 -0400
Received: (qmail invoked by alias); 17 Sep 2007 13:53:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 17 Sep 2007 15:53:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zSVEtDm+zTbCJafyDCvjcHSl7HMWi4Ydbtkod+k
	bjDR+EZhME3p48
X-X-Sender: gene099@racer.site
In-Reply-To: <20070917133742.GA10923@pe.Belkin>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58444>

Hi,

On Mon, 17 Sep 2007, Chris Shoemaker wrote:

> On Mon, Sep 17, 2007 at 02:23:38PM +0100, Johannes Schindelin wrote:
>
> > "git svn fetch && git rebase git-svn" might be a better approach [...]
> 
> BTW, this is spelled "git svn rebase" these days.

Heh.  Missed that.

Thanks,
Dscho
