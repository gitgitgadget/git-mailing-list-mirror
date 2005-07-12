From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] tagger id
Date: Tue, 12 Jul 2005 11:54:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507121152260.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
 <m1eka574c8.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
 <m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
 <m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com> <m18y0c1prv.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 20:55:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsPuc-0004uN-VT
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 20:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVGLSym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 14:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVGLSym
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 14:54:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3487 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262022AbVGLSyJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 14:54:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6CIs7jA022071
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 12 Jul 2005 11:54:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6CIs5Ig027905;
	Tue, 12 Jul 2005 11:54:05 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m18y0c1prv.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Eric,
 I ended up coding the ident stuff a bit differently, and I didn't do done
the tag/git-id part yet. Can you check out my latest commit (pushed out, 
but it will probably take a few minutes to mirror out), and do the final 
tag stuff based on that? 

		Linus
