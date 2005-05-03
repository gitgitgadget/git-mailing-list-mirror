From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH 0/3] cogito spec file updates
Date: Tue, 3 May 2005 12:35:36 -0700
Message-ID: <20050503193536.GE5324@shell0.pdx.osdl.net>
References: <20050503182850.GL18917@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 21:30:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT35Y-0003wK-J6
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVECTf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVECTf4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:35:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:35974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261636AbVECTfl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 15:35:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43JZas4012296
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 12:35:37 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43JZaEE011679;
	Tue, 3 May 2005 12:35:36 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j43JZa2p011678;
	Tue, 3 May 2005 12:35:36 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050503182850.GL18917@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> Here's the outstanding updates for the spec file, up to 0.8-2 which is
> the latest on kernel.org.
> 
> 	http://www.kernel.org/pub/software/scm/cogito/RPMS/

What's your method for creating a release tarball?  If it were formalized
(i.e. Makefile rule), then it'd be simple to use VERSION to drive the
spec file, and it'd only need updating for real content changes (similar
to what Kay did).

thanks,
-chris
