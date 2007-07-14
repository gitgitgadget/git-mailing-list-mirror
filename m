From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git-rebase -i to allow squashing of fast-forwardable
 commits
Date: Sat, 14 Jul 2007 10:53:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707141052510.14781@racer.site>
References: <20070712223035.GB30532@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 11:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9eJd-0006pk-0J
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 11:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611AbXGNJxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 05:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754447AbXGNJxX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 05:53:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:60358 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755611AbXGNJxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 05:53:23 -0400
Received: (qmail invoked by alias); 14 Jul 2007 09:53:20 -0000
Received: from R063a.r.pppool.de (EHLO noname) [89.54.6.58]
  by mail.gmx.net (mp057) with SMTP; 14 Jul 2007 11:53:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SQVwTL/QSVdAudP0/BPCsNv4SPnoJ0F1bHFn8g+
	yuRyeqevZTdQnU
X-X-Sender: gene099@racer.site
In-Reply-To: <20070712223035.GB30532@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52459>

Hi,

On Fri, 13 Jul 2007, Alex Riesen wrote:

> Without this change the commits will be left standalone, with
> duplicated commit message.

Thanks.

Ciao,
Dscho
