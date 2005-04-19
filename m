From: Daniel Barkalow <barkalow@iabervon.org>
Subject: More patches
Date: Mon, 18 Apr 2005 21:48:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:44:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhmN-0001Px-DW
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVDSBry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDSBry
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:47:54 -0400
Received: from iabervon.org ([66.92.72.58]:12038 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261262AbVDSBrw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 21:47:52 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNhqR-0004O9-00; Mon, 18 Apr 2005 21:48:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here are the things I was saving for after the previous set:

 1: Report the actual contents of trees
 2: Add functions for scanning history by date
 3: Add http-pull, a program to fetch the objects you need by HTTP
 4: Change merge-base to find the most recent common ancestor

1 and 2 are core extensions. 3 might be best for the pasky tree. 4 is
mostly a demo of 2 and because Linus thought it was a better algorithm.

	-Daniel
*This .sig left intentionally blank*

