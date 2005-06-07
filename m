From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/4] Generic support for pulling refs
Date: Tue, 7 Jun 2005 12:45:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506071134450.30848-100000@iabervon.org>
References: <1118150337.8970.49.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT Mailling list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 18:43:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfh9v-0000lm-CU
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 18:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVFGQqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 12:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVFGQqQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 12:46:16 -0400
Received: from iabervon.org ([66.92.72.58]:34564 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261880AbVFGQqN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 12:46:13 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DfhCJ-00065U-00; Tue, 7 Jun 2005 12:45:03 -0400
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
In-Reply-To: <1118150337.8970.49.camel@jmcmullan.timesys>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 7 Jun 2005, McMullan, Jason wrote:

> Well, looks like you beat me to the punch, Daniel!
> 
> I hereby concede the Deathmatch to git-ssh-pu{sh,ll}, and withdraw
> git-sync from consideration.
> 
> Way to go Daniel!
> 
> "Welcome to Git Thunderdome. Two codes enter, one code leaves."

Of course, my secret is that I actually wrote it all in advance, so I just
had to polish it up, rebase, and document the program that was already
in...

Back on topic, are there things you need that git-ssh-* doesn't do? It
would still be good to get the code to write objects to temporary files
until they're determined to be valid.

	-Daniel
*This .sig left intentionally blank*

