From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/4] gitweb: Whitespace cleanup - tabs are for indent,
 spaces are for align (2)
Date: Sun, 22 Oct 2006 14:03:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610221359090.3962@g5.osdl.org>
References: <200610211750.49188.jnareb@gmail.com> <200610211752.19891.jnareb@gmail.com>
 <7v3b9g5cde.fsf@assigned-by-dhcp.cox.net> <200610222236.45414.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 23:03:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbkTk-0006KD-Qz
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 23:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWJVVD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 17:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWJVVD3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 17:03:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751401AbWJVVD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 17:03:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9ML3LaX025750
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 Oct 2006 14:03:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9ML3Kd9001250;
	Sun, 22 Oct 2006 14:03:21 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610222236.45414.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29792>



On Sun, 22 Oct 2006, Jakub Narebski wrote:
> 
> To be true I do those "whitespace cleanup" patches when I notice
> that something is mis-aligned for _my_ tab width (2 spaces).

Oh, wow.

You have clearly been damaged by some nasty GNU coding style or similar.

Please immediately turn tabs into 8 character hard-tabs, and read the 
kernel Documentation/CodingStyle document.

After that, you may have to go to some detox unit to purge yourself of the 
habit of 2-character indents, and I realize it will be hard and you'll 
feel like shit for a while, but you'll be a better person for it.

It's like kicking a bad drug habit. It may be painful for a while, and you 
might wistfully think back on the "happy days" when things went by in a 
haze of unclear indentations, but really, it's worth it.

			Linus
