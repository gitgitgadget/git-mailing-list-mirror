From: Tom Lord <lord@emf.net>
Subject: Re: Hash collision count
Date: Mon, 25 Apr 2005 16:50:31 -0700 (PDT)
Message-ID: <200504252350.QAA02241@emf.net>
References: <20050423234637.GS13222@pasky.ji.cz>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 01:46:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQDH3-00041d-4w
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 01:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVDYXuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 19:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVDYXuq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 19:50:46 -0400
Received: from emf.emf.net ([205.149.0.19]:59398 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261177AbVDYXun (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 19:50:43 -0400
Received: (from lord@localhost) by emf.net (K/K) id QAA02241; Mon, 25 Apr 2005 16:50:31 -0700 (PDT)
To: pasky@ucw.cz
In-reply-to: <20050423234637.GS13222@pasky.ji.cz> (message from Petr Baudis on Sun, 24 Apr 2005 01:46:37 +0200)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


  From: Petr Baudis <pasky@ucw.cz>

  Pasky:

  > No, a collision is pretty common thing, actually. It's the main power of
  > git, actually - when you do read-tree, modify it and do write-tree
  > (typically when doing commit), everything you didn't modify (99% of
  > stuff, most likely) is basically a collision - but it's ok since it
  > just stays the same.

That is not the way people ordinarily use the word "collision".
It's pretty much the opposite of the normal way, actually.

-t
