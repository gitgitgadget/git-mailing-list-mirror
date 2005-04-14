From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 10:42:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org>
 <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org>
 <425E0D62.9000401@zytor.com> <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>
 <425EA152.4090506@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christopher Li <git@chrisli.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 19:38:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM8Hl-0006me-EP
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 19:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVDNRlH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 13:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVDNRlH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 13:41:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:2236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261571AbVDNRlB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 13:41:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3EHexs4023764
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 10:40:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3EHevg0007971;
	Thu, 14 Apr 2005 10:40:58 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425EA152.4090506@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, H. Peter Anvin wrote:
> 
> Eh?!  n_link limits the number of *subdirectories* a directory can 
> contain, not the number of *entries*.

Duh. I'm a git.

		Linus
