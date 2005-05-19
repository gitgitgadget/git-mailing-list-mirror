From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: manpage name conflict
Date: Thu, 19 May 2005 09:47:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505190945440.2322@ppc970.osdl.org>
References: <E1DYmy8-0003YB-JW@highlab.com> <20050519155804.GB4513@pasky.ji.cz>
 <E1DYnpO-0003cF-I6@highlab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 18:45:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYo8f-0000X4-Bf
	for gcvg-git@gmane.org; Thu, 19 May 2005 18:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVESQpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 12:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVESQpP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 12:45:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:20442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261151AbVESQpF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 12:45:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4JGj0U3029446
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 09:45:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4JGixoG029539;
	Thu, 19 May 2005 09:44:59 -0700
To: Sebastian Kuzminsky <seb@highlab.com>
In-Reply-To: <E1DYnpO-0003cF-I6@highlab.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Sebastian Kuzminsky wrote:
> 
> But what is going to be the name of the git package?  Let's please
> not make it "git", because that's taken by the GNU Interactive Tools.
> How about "git-core" or "git-plumbing" or "linus-is-a-git"?

"git-core" sounds good to me. I don't mind "linus-is-a-git" either, but I
suspect it would end up confusing people if the git packages are installed
with something that starts with "linus-"

		Linus
