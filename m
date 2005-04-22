From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: [PATCH] git-pasky spec file
Date: Fri, 22 Apr 2005 10:16:28 -0400
Message-ID: <4269073C.1080802@qualitycode.com>
References: <20050422015521.GK493@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:16:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyt8-0004qx-FH
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 16:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVDVOQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 10:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVDVOQi
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 10:16:38 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:24181 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261891AbVDVOQg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 10:16:36 -0400
Received: from [10.10.10.20] (147-49.35-65.tampabay.res.rr.com [65.35.49.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id AE4F83C14;
	Fri, 22 Apr 2005 14:16:26 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050422015521.GK493@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wright wrote:
> Here's a simple spec file to do rpm builds.

(snip)

> Creates a package named git, which seems
> fine since Linus' isn't likely to be packaged directly.  

Um. Really? I can't imagine why Linus's git wouldn't be packaged
directly. He has strongly indicated that folks who want to build on top
of it should not expect to see libgit any time soon, so git will be an
important independent tool.

But presumably you'll change the name of this package to cogito soon
anyway, as soon as git-pasky itself is renamed.

Kevin
