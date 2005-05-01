From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [0/2] Complete http-pull
Date: Sun, 1 May 2005 17:49:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505011746230.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 23:46:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSMGg-0003dL-JB
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVEAVve (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVEAVuZ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:50:25 -0400
Received: from iabervon.org ([66.92.72.58]:42244 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262728AbVEAVuG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 17:50:06 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSMK5-0002QZ-00; Sun, 1 May 2005 17:49:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series enables http-pull to do everything renecessary to bring your
local repository up to date with respect to a remote repository by HTTP.

 1: Library support for files in refs
 2: Fetch refs over the network and write them locally

	-Daniel
*This .sig left intentionally blank*


