From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Add t/t6003 with some --topo-order tests
Date: Wed, 6 Jul 2005 18:01:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507061800550.3293@g5.osdl.org>
References: <20050707005004.9205.qmail@blackcubes.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 03:04:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqKo0-0005kn-Jw
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 03:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVGGBD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 21:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVGGBDQ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 21:03:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262421AbVGGBB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 21:01:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6711NjA018859
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Jul 2005 18:01:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6711MIZ004584;
	Wed, 6 Jul 2005 18:01:22 -0700
To: Jon Seymour <jon.seymour@gmail.com>
In-Reply-To: <20050707005004.9205.qmail@blackcubes.dyndns.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Jon Seymour wrote:
>
> Linus: the last test fails with --topo-order at the moment. I haven't
> seen your most recent changes, so it may still fail for trivial 
> reasons even then. If so, I'll post an update.

It passes for me, so I think the SEEN flag thing fixed it.

		Linus
