From: Tom Lord <lord@emf.net>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 13:49:52 -0700 (PDT)
Message-ID: <200504272049.NAA14598@emf.net>
References: <426FF8C4.8080809@zytor.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 22:45:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtOz-0007tK-Lf
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVD0UuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 16:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVD0UuL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 16:50:11 -0400
Received: from emf.emf.net ([205.149.0.19]:784 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262007AbVD0Ut5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 16:49:57 -0400
Received: (from lord@localhost) by emf.net (K/K) id NAA14598; Wed, 27 Apr 2005 13:49:52 -0700 (PDT)
To: hpa@zytor.com
In-reply-to: <426FF8C4.8080809@zytor.com> (hpa@zytor.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


   From: "H. Peter Anvin" <hpa@zytor.com>

   Linus Torvalds wrote:
   > 
   > No, that's definitely _not_ the point.
   > 
   > I repeat: git does not do any free-form parsin AT ALL. The links are in 
   > well-defined places, and you do not ever search for them. And that's 
   > really very very important.
   > 

   I know that.  However, is that going to be true for all versions of the 
   repository format over all time?  If so, the repository format is brittle.

I think one has to understand Linus' posts as coming from the
"head-down, steaming ahead for *MY* project cause you all suck"
perspective and impose corresponding filters on his declarations of
"LAW".  At least that's the only way *I* can make sense of his latest
contributions.

If you get git, just do the right thing -- Linus be damned.

-t

