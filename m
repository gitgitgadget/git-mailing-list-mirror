From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Makefile: Add install-lib and install-include targets
Date: Thu, 6 Sep 2007 09:39:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709060938570.28586@racer.site>
References: <20070905232213.GB331@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 10:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITCuO-0000TC-86
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 10:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbXIFIkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 04:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbXIFIkK
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 04:40:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:34779 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753963AbXIFIkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 04:40:09 -0400
Received: (qmail invoked by alias); 06 Sep 2007 08:40:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 06 Sep 2007 10:40:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5xsUnMlu5zvPgwobNlVzeuGevL2/r62uN5bgWI2
	/Xr71trT3V6SvA
X-X-Sender: gene099@racer.site
In-Reply-To: <20070905232213.GB331@nomad.office.altlinux.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57840>

Hi,

On Thu, 6 Sep 2007, Dmitry V. Levin wrote:

> Several external projects (e.g. parsecvs) need libgit library
> and related header files.

but does that not pretend that we have a stable API?  Which we have not at 
all, thank you very much.  However, Luiz created a thin libgit in his GSoC 
project, and IMHO this would be the way to continue.  If it is not 
complete enough, well, complete it.

Ciao,
Dscho
