From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The big git command renaming..
Date: Fri, 29 Apr 2005 15:14:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291511410.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org>
 <20050429213540.GA1691@redhat.com> <4272AE05.2070202@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:07:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdds-0001X4-Fb
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 00:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbVD2WNC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 18:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVD2WNC
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 18:13:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:19136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263027AbVD2WM5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 18:12:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TMCms4016798
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 15:12:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TMClsR008338;
	Fri, 29 Apr 2005 15:12:48 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4272AE05.2070202@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, H. Peter Anvin wrote:
> 
> Oh yes, and can that tarball please be put in /pub/software/scm/git, and 
> the associated git tree be moved to /pub/scm/git?

Sure. 

Just a quick question: what are the "rules" for /pub/scm/git? 

Should I put just git in it, or is it meant for any "git project", and
should I also copy the 2.6.x kernel home from

	/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

to

	/pub/scm/git/linux-2.6.git

or what?

Me, I can do either or both, I just don't know what the intent was..

		Linus

