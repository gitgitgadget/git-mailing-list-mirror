From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] cherry-pick: make -r the default
Date: Thu, 5 Oct 2006 18:20:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610051820110.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0610051711310.3952@g5.osdl.org>
 <7vsli245zp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 03:21:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVeOo-0005NL-7S
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 03:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWJFBVD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 21:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWJFBVD
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 21:21:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932551AbWJFBVB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 21:21:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k961KuaX030128
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Oct 2006 18:20:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k961Ktf6012792;
	Thu, 5 Oct 2006 18:20:56 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsli245zp.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.461 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28383>



On Thu, 5 Oct 2006, Junio C Hamano wrote:
> 
>    Thanks for reminding.  Does the rationale and warning for -x
>    in the documentation look Ok?

Looks good, thanks.

		Linus
