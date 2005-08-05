From: Chris Wright <chrisw@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.13
Date: Thu, 4 Aug 2005 19:39:13 -0700
Message-ID: <20050805023913.GA8041@shell0.pdx.osdl.net>
References: <20050805020307.GP24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 04:41:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0s8A-0001dq-KX
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 04:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVHECjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 22:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVHECjd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 22:39:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262834AbVHECjV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 22:39:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j752dDjA018143
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 4 Aug 2005 19:39:13 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j752dD3t022724;
	Thu, 4 Aug 2005 19:39:13 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j752dDA3022723;
	Thu, 4 Aug 2005 19:39:13 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050805020307.GP24479@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Petr Baudis (pasky@suse.cz) wrote:
> 	* Cogito is now alone!
> 		GIT is no longer part of Cogito distribution.
> 		That means you need to get and install it separately.
> 		It is recommended to use at least 0.99.3. The newer
> 		the better (hopefully).

That's great.  RPMs uploading to:

 	http://www.kernel.org/pub/software/scm/cogito/RPMS

I think we can make this a noarch rpm since it's scripts only now.

thanks,
-chris
