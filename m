From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] tar-tree: add the "tar.applyUmask" config option
Date: Thu, 20 Jul 2006 00:39:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607200038580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060719214025.GA10997@1wt.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu Jul 20 00:40:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3Khs-0004z6-45
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 00:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWGSWjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 18:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWGSWjm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 18:39:42 -0400
Received: from mail.gmx.de ([213.165.64.21]:6614 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932556AbWGSWjl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 18:39:41 -0400
Received: (qmail invoked by alias); 19 Jul 2006 22:39:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 20 Jul 2006 00:39:40 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Willy Tarreau <w@1wt.eu>
In-Reply-To: <20060719214025.GA10997@1wt.eu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24010>

Hi,

while at it, you could ask an explicit "--umask=<n>" flag, no?

Ciao,
Dscho
