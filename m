From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 1 Oct 2006 12:57:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610011256580.3952@g5.osdl.org>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net> <7vd59c2vev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610011132040.3952@g5.osdl.org>
 <Pine.LNX.4.63.0610012052520.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 21:57:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU7RR-0006gx-CQ
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 21:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWJAT5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 15:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWJAT5e
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 15:57:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59807 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932253AbWJAT5d (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 15:57:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k91JvQaX027266
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 Oct 2006 12:57:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k91JvPLa028716;
	Sun, 1 Oct 2006 12:57:26 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610012052520.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.448 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28197>



On Sun, 1 Oct 2006, Johannes Schindelin wrote:
> 
> Just rm perl/{Git.{bs,c},Makefile} and remake.

Now this works.

So somebody tell me why we even invoke that Makefile that shouldn't be 
there?

		Linus
