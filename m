From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Make rsh protocol extensible
Date: Fri, 3 Jun 2005 17:38:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506031737090.30848-100000@iabervon.org>
References: <20050602205912.GD32189@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 23:37:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeJqi-00066w-81
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 23:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVFCVkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 17:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVFCVkG
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 17:40:06 -0400
Received: from iabervon.org ([66.92.72.58]:56324 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261487AbVFCVjy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 17:39:54 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DeJsQ-0001q3-00; Fri, 3 Jun 2005 17:38:50 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050602205912.GD32189@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Jun 2005, Petr Baudis wrote:

> Dear diary, on Thu, May 19, 2005 at 07:11:46AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > This changes the rsh protocol to allow reporting failure in getting an
> > object without breaking the connection, and to allow other types of
> > request than for objects to be made. It is a preliminary to any more
> > extensive pull operation.
> > 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> 
> I wanted to apply it but then I figured out that I will better hold it
> and ask you what do you think about it now after few weeks. ;-) Should I
> still go on and apply it to Cogito?

At this point, I want to also put in a protocol version number. I'll send
a replacement patch in a bit.

	-Daniel
*This .sig left intentionally blank*

