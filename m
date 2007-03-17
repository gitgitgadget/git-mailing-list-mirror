From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "Patch is empty.  Was is split wrong?"
Date: Fri, 16 Mar 2007 19:26:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703161925190.3910@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 17 03:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSOdO-000822-KV
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 03:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbXCQC1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 22:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbXCQC1D
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 22:27:03 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47510 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615AbXCQC1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 22:27:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2H2QvcD014640
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Mar 2007 19:26:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2H2Qv3M027054;
	Fri, 16 Mar 2007 18:26:57 -0800
X-Spam-Status: No, hits=-0.481 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42418>


My usage of "git-applymbox -u" these days always results in these bogus 
warnings:

	Patch is empty.  Was is split wrong?
	/home/torvalds/bin/git-applymbox: line 82: stop_here: command not found

but then it applies the patch anyway.

Hmm? I've not looked into it any more yet.

		Linus
