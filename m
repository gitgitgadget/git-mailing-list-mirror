From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: xmemdup patches
Date: Mon, 17 Sep 2007 17:39:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171739010.28586@racer.site>
References: <20070917161113.GB460@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:40:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJdx-0007ap-TT
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbXIQQkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbXIQQkM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:40:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:59915 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753078AbXIQQkK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:40:10 -0400
Received: (qmail invoked by alias); 17 Sep 2007 16:40:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 17 Sep 2007 18:40:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Du8Rg53zD/3Aexa2Pns9cKdS3EMNZWL5QEQjOQB
	w0vkzB/KguPj+Q
X-X-Sender: gene099@racer.site
In-Reply-To: <20070917161113.GB460@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58461>

Hi,

On Mon, 17 Sep 2007, Pierre Habouzit wrote:

>   I'm not a huge fan of "xmemdup" as I would not have supposed that a
> function called like that would add the extra NUL, so I'm 100% okay with
> someone coming up with any better name.

xmemdupz()?

Ciao,
Dscho
