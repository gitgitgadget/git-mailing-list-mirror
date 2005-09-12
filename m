From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 16:26:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509121622520.23242@iabervon.org>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
 <4325A0D9.2000806@gmail.com> <4325AED6.8050401@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 22:24:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEupA-0007vu-7C
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 22:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVILUWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 16:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVILUWl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 16:22:41 -0400
Received: from iabervon.org ([66.92.72.58]:47122 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932205AbVILUWk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 16:22:40 -0400
Received: (qmail 25104 invoked by uid 1000); 12 Sep 2005 16:26:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Sep 2005 16:26:46 -0400
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <4325AED6.8050401@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8423>

On Mon, 12 Sep 2005, Chuck Lever wrote:

> A Large Angry SCM wrote:
> > Since you are proposing an API, some basic documentation about how to use
> > the API would be nice. Comments in cache.h seems the best place, for now.
> 
> actually it might be best to have a list discussion first.  if i can answer
> questions and provide a few explanations here, the list archive might be a
> reasonable resting place for documentation.
> 
> the API is fairly simple and is documented via the function names. there isn't
> a whole lot of function-level documentation in the git code base that i have
> seen, so i erred on the side of less is more.
> 
> the main pieces are:
> 
> +  next_name
> 
> which skips to the next unique name in the cache.

Something with "cc" in it?

	-Daniel
*This .sig left intentionally blank*
