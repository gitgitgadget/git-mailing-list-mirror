From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: I want to release a "git-1.0"
Date: Thu, 2 Jun 2005 17:06:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506021705520.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <m1psv7bjb6.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
 <00e101c567cc$80c0de80$03c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 02:01:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddzcv-0007Ih-Sb
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 02:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVFCAEc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 20:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVFCAEc
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 20:04:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:32481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261451AbVFCAE3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 20:04:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5304QjA032208
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Jun 2005 17:04:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5304PUq027770;
	Thu, 2 Jun 2005 17:04:25 -0700
To: Adam Kropelin <akropel1@rochester.rr.com>
In-Reply-To: <00e101c567cc$80c0de80$03c8a8c0@kroptech.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 2 Jun 2005, Adam Kropelin wrote:
> What confuses me is the following:

Yeah, I'll try to clarify.

git-diff-cache can show the difference between a tree and either the index 
_or_ the working directory. Will fix up.

		Linus
