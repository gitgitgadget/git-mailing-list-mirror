From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Git fork removal?
Date: Wed, 27 Apr 2005 21:31:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504272127400.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:26:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxn8-0004vL-BE
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVD1BbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVD1BbZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:31:25 -0400
Received: from iabervon.org ([66.92.72.58]:49414 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261573AbVD1BbT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 21:31:19 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQxs7-0001yk-00; Wed, 27 Apr 2005 21:31:19 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I saw that "fork" was removed when going to the cg- scripts, and the
replacements don't do the symlinked trees thing. I found the symlinked
trees thing vital to my workflow, so I'm going to want to reintroduce
them, or something similar. Is there some reason you went to hardlinked
object files instead of symlinked directories?

	-Daniel
*This .sig left intentionally blank*

