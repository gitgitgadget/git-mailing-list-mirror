From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sun, 28 Jan 2007 15:49:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701281549070.3611@woody.linux-foundation.org>
References: <20070127062826.GE14205@fieldses.org> <20070128002246.GA10179@moooo.ath.cx>
 <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
 <20070128013452.GA11244@moooo.ath.cx> <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
 <20070128233445.GD12125@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 00:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBJmM-0007AT-Ej
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 00:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbXA1Xtn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 18:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933014AbXA1Xtn
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 18:49:43 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42367 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933011AbXA1Xtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 18:49:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0SNnV1m007084
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 Jan 2007 15:49:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0SNnUNa006311;
	Sun, 28 Jan 2007 15:49:31 -0800
In-Reply-To: <20070128233445.GD12125@fieldses.org>
X-Spam-Status: No, hits=-2.474 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38057>



On Sun, 28 Jan 2007, J. Bruce Fields wrote:
> 
> While we're at it, is there any need for the "objects" in
> git-fsck-objects?

Not really. We should probably just add that alias too.

		Linus
