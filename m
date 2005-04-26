From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: (SOLVED) Re: cg-add and update-cache add fails
Date: Tue, 26 Apr 2005 13:51:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504261349210.30848-100000@iabervon.org>
References: <200504261744.44394.rhys@rhyshardwick.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 19:50:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUBH-0001al-QJ
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 19:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDZRxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 13:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDZRwU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 13:52:20 -0400
Received: from iabervon.org ([66.92.72.58]:50439 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261706AbVDZRvy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 13:51:54 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQUDy-0008AE-00; Tue, 26 Apr 2005 13:51:54 -0400
To: Rhys Hardwick <rhys@rhyshardwick.co.uk>
In-Reply-To: <200504261744.44394.rhys@rhyshardwick.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Apr 2005, Rhys Hardwick wrote:

> Ok, I have been known to be silly.  But this silly? :)
> 
> Create the file, then add it to the repository.  Makes sense really.

You might do well to send in a patch that gives a useful error message,
like "something.c: File not found", since other people have been known to
be silly, too.

	-Daniel
*This .sig left intentionally blank*

