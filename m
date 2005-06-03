From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 17:33:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506031727400.30848-100000@iabervon.org>
References: <20050603152212.GA4598@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Fri Jun 03 23:32:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeJkx-0005Tw-CE
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 23:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFCVeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFCVeO
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 17:34:14 -0400
Received: from iabervon.org ([66.92.72.58]:47108 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261392AbVFCVeM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 17:34:12 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DeJmz-0001pa-00; Fri, 3 Jun 2005 17:33:13 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <20050603152212.GA4598@jmcmullan.timesys>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Jun 2005, Jason McMullan wrote:

> git-daemon - Client/server for exchanging GIT objects

Is this somehow different from rpush/rpull aside from using an
externally-provided socket and having the proper locking for writing refs
(which I posted a while ago, but which hasn't been included anywhere yet)?

	-Daniel
*This .sig left intentionally blank*

