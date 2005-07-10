From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Handing sending objects from packs
Date: Sun, 10 Jul 2005 18:22:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101811390.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 00:29:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrkHm-0004vo-Dx
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 00:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVGJW1S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 18:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVGJWYl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 18:24:41 -0400
Received: from iabervon.org ([66.92.72.58]:45574 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262114AbVGJWYE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 18:24:04 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DrkBb-0005tR-00; Sun, 10 Jul 2005 18:22:07 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series adds support for sending individual objects from packs in in
git-ssh-push and removes map_sha1_file.

	-Daniel
*This .sig left intentionally blank*
