From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Use libcurl to use HTTP to get repositories
Date: Sat, 16 Apr 2005 20:42:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504162033060.30848-100000@iabervon.org>
References: <20050416172952.3bf34bab.pj@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Apr 17 02:38:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxo4-0000LC-KY
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVDQAmK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVDQAmK
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:42:10 -0400
Received: from iabervon.org ([66.92.72.58]:22788 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261222AbVDQAl5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 20:41:57 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMxrZ-0000Qr-00; Sat, 16 Apr 2005 20:42:13 -0400
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050416172952.3bf34bab.pj@sgi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Paul Jackson wrote:

> > Needs libcurl post 7.7 or so.
> 
> That could be mentioned in the README, which has a list of 'Software
> requirements.'  Actually, zlib-devel and openssl should be on this list
> as well.  My laziness got in the way of my sending in a patch for that.

I'm working off of Linus's tree when not working on scripts, and it
doesn't have that section at all. Should I submit patches to the pasky
tree? (I'm actually tempted to have my own public tree, now that I
wouldn't have to set up anonymous rsync access, aside from the
bootstrapping issue; then I could let people pull and merge instead of
applying patches.)

	-Daniel
*This .sig left intentionally blank*

