From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Mon, 18 Sep 2006 10:17:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609181012180.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060918004831.GA19851@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 10:17:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPEJx-0000Gh-LH
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 10:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965561AbWIRIRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 04:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965562AbWIRIRi
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 04:17:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:11691 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965561AbWIRIRh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 04:17:37 -0400
Received: (qmail invoked by alias); 18 Sep 2006 08:17:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 18 Sep 2006 10:17:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060918004831.GA19851@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27241>

Hi,

the only gripe I have with it: whenever some options are added, or 
removed, or renamed, you have to adapt the completion script. That is why 
I started (ages ago) to auto-generate the completion script from the 
documentation (of course, this means that the options have to be described 
consistently in the documentation, which is good in its own).

Unfortunately, I never got around to finish it, but a preliminary version 
is in the mailing list archives.

However, since your script works well, and I do not have a working script, 
you clearly won! So, unless some kind soul actually implements my 
proposal, I am happy with your script.

Ciao,
Dscho
