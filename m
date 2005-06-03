From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 10:50:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506031050080.1876@ppc970.osdl.org>
References: <20050603152212.GA4598@jmcmullan.timesys>
 <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org> <7vr7fjml35.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason McMullan <jason.mcmullan@timesys.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:47:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeGEQ-0001yZ-Bp
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 19:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVFCRs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 13:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFCRs2
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 13:48:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:9709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261423AbVFCRs0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 13:48:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53HmJjA012505
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 10:48:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53HmI3j003388;
	Fri, 3 Jun 2005 10:48:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7fjml35.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, Junio C Hamano wrote:
> 
> That particular name risks conflicting name with other
> git-servers offering different service for git; gitweb is a
> git-server isn't it?  git-sync might be better fit.

Yeah, you're right.

		Linus
