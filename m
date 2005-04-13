From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Various cleanups
Date: Wed, 13 Apr 2005 17:52:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504131556510.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504131547330.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 23:49:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLpj4-0007Bt-B7
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 23:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDMVv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 17:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVDMVv7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 17:51:59 -0400
Received: from iabervon.org ([66.92.72.58]:21765 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261213AbVDMVv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 17:51:56 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DLpmO-0000Oa-00; Wed, 13 Apr 2005 17:52:12 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504131547330.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As it turns out, I ended up with two patches: one to set up the Makefile,
and one to reorganize the common code. I'll do another one later to split
stuff out of rev-tree/fsck-cache once merge-base is in.

The reorganization depends on the Makefile.

	-Daniel
*This .sig left intentionally blank*

