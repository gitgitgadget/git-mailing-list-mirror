From: Fabian Franz <FabianFranz@gmx.de>
Subject: Re: [PATCH] update-cache.c ignore directories
Date: Sat, 23 Apr 2005 00:27:10 +0200
Message-ID: <200504230027.14833.FabianFranz@gmx.de>
References: <1114208707.12699@tsunami.he.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:27:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6bU-0000RR-5T
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVDVWa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDVWa7
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:30:59 -0400
Received: from pop.gmx.net ([213.165.64.20]:56522 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261240AbVDVWaz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 18:30:55 -0400
Received: (qmail invoked by alias); 22 Apr 2005 22:30:54 -0000
Received: from p54A3EE36.dip.t-dialin.net (EHLO ff.cornils.net) [84.163.238.54]
  by mail.gmx.net (mp023) with SMTP; 23 Apr 2005 00:30:54 +0200
X-Authenticated: #590723
To: "atani" <atani@atani-software.net>
User-Agent: KMail/1.5.4
In-Reply-To: <1114208707.12699@tsunami.he.net>
Content-Description: clearsigned data
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Am Samstag, 23. April 2005 00:25 schrieb atani:

> Now it spits out:
> -------------
> 'plx' is a directory, ignoring
> -------------

I saw that you spit this out to stdout. Wouldn't it be better to spit it out 
to stderr (even if its just a warning)?

cu

Fabian

