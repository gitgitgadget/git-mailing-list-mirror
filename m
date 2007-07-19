From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 12:13:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191211010.14781@racer.site>
References: <20070719104351.GA17182@midwinter.com>
 <20070719110224.GA4293@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTwX-00019R-PZ
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 13:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbXGSLNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 07:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbXGSLNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 07:13:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:40219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751265AbXGSLNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 07:13:07 -0400
Received: (qmail invoked by alias); 19 Jul 2007 11:13:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 19 Jul 2007 13:13:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wST8JiQEwWeniJOQQyXzQ26x28t1DZrc5bE/bnO
	tpwGct6keSOxHL
X-X-Sender: gene099@racer.site
In-Reply-To: <20070719110224.GA4293@piper.oerlikon.madduck.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52969>

Hi,

On Thu, 19 Jul 2007, martin f krafft wrote:

> [...] I also wonder why use of a pager is default in git anyway. At 
> least I find it to be contrary to what I am used to on the Unix command 
> line.

It was evidently liked unilaterally amongst the big whigs in the git 
community.  Me too, I like it (which says nothing about my hair style).  
Often it annoys me tremendously that all the other programs like make, ls, 
etc. do not have this nice "-p" flag.

Ciao,
Dscho
