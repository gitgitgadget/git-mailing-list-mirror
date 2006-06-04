From: Linus Torvalds <torvalds@osdl.org>
Subject: More verbose "git fetch"?
Date: Sat, 3 Jun 2006 18:11:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606031809550.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jun 04 03:12:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmhA1-0006wk-Gu
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 03:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWFDBMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 21:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWFDBMF
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 21:12:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751082AbWFDBMC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 21:12:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k541Bw2g014442
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Jun 2006 18:11:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k541Bw6l028652;
	Sat, 3 Jun 2006 18:11:58 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21238>


Is it just me who has been getting less accepting, or has "git fetch" 
gotten more verbose?

Has it always spit out those annoying

	xyz: same as branch 'xyz' of so-and-so-repo

even without "-v"? I thought I killed them at some point, but 
either they're back, or I'm just confused.

		Linus
