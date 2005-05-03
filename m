From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH 0/3] cogito spec file updates
Date: Tue, 3 May 2005 16:01:52 -0700
Message-ID: <20050503230152.GX18917@shell0.pdx.osdl.net>
References: <20050503211527.42339.qmail@web41208.mail.yahoo.com> <20050503182850.GL18917@shell0.pdx.osdl.net> <20050503193536.GE5324@shell0.pdx.osdl.net> <20050503212142.GB15995@pasky.ji.cz> <20050503213216.GF5324@shell0.pdx.osdl.net> <20050503214401.GE15995@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, Mark Allen <mrallen1@yahoo.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 00:55:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6Ii-0000QV-Jf
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVECXB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVECXB4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:01:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:54465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261897AbVECXBz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 19:01:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43N1qs4029179
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 16:01:52 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43N1qXU022770;
	Tue, 3 May 2005 16:01:52 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j43N1q8H022769;
	Tue, 3 May 2005 16:01:52 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050503214401.GE15995@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Petr Baudis (pasky@ucw.cz) wrote:
> I wouldn't accept this neither. If git.spec is already version
> controlled, it should be up-to-date in the version control. Therefore,
> you need to update it at the time of release, not at the time of
> generating the tarball.

*shrug*

Well, it's guaranteed to be one step out of sync, but I'll just keep
doing what I've been doing.  Build rpm after you release, and send
patch ex-post-facto.

thanks,
-chris
