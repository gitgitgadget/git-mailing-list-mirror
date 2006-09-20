From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Public Gitweb Hosting Service
Date: Tue, 19 Sep 2006 20:35:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609192033050.4388@g5.osdl.org>
References: <20060920004828.GI8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 05:35:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPsrw-0002BW-7l
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 05:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWITDfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 23:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWITDfK
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 23:35:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750994AbWITDfI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 23:35:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8K3Z3nW014118
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Sep 2006 20:35:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8K3Z247015834;
	Tue, 19 Sep 2006 20:35:02 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060920004828.GI8259@pasky.or.cz>
X-Spam-Status: No, hits=-0.929 required=5 tests=AWL,HTML_MESSAGE,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27326>



On Wed, 20 Sep 2006, Petr Baudis wrote:
> 
>   It's running at
> 
> 	http://repo.or.cz/

Well, "running" may be putting it a bit strongly.

When I click "summary" for the glibc-cvs.git tree, I get just a

	<div class="title">&nbsp;</div>
	-------------------^

thing back.

Broken gitweb?

		Linus
