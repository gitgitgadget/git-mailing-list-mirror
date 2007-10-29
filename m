From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug in git-show with "%ai" and "%ci" formats?
Date: Mon, 29 Oct 2007 13:32:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710291331310.4362@racer.site>
References: <4A647262-B69A-4DB6-942C-18C45458B169@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 14:33:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImUkI-0005M0-07
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 14:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbXJ2NdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 09:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbXJ2NdR
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 09:33:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:51134 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751863AbXJ2NdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 09:33:16 -0400
Received: (qmail invoked by alias); 29 Oct 2007 13:33:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 29 Oct 2007 14:33:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NDykdQWfNr+LcW/rrgELh9AUZxK9bLzUTGry/pG
	qiginPwfvxv/Es
X-X-Sender: gene099@racer.site
In-Reply-To: <4A647262-B69A-4DB6-942C-18C45458B169@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62617>

Hi,

On Mon, 29 Oct 2007, Wincent Colaiuta wrote:

> Can anybody reproduce the following behaviour? Basically all the author and
> committer date formats documented in the git-show man page work except for
> "%ai" and "%ci". This is with Git 1.5.2.4 running on Darwin 9.0.0:

It was added in v1.5.3-rc2~17.

Usually, it is a good idea to use the documentation which corresponds with 
the git version you are using ;-)

Hth,
Dscho
