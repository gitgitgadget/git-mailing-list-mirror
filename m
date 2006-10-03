From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 3 Oct 2006 09:31:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610030928160.3952@g5.osdl.org>
References: <20061002191115.84730.qmail@web31811.mail.mud.yahoo.com>
 <200610022203.44733.jnareb@gmail.com> <7v1wpqujck.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 18:31:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUnB3-0003J0-GR
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 18:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWJCQb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 12:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWJCQbZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 12:31:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750701AbWJCQbY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 12:31:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k93GVIaX026149
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Oct 2006 09:31:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k93GVHgk001261;
	Tue, 3 Oct 2006 09:31:17 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wpqujck.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.455 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28276>



On Mon, 2 Oct 2006, Junio C Hamano wrote:
> 
> Honestly, I _hate_ to be in the position to decide in which
> color the bikeshed should be, but sometimes that is what a
> maintainer has to do.

Quite often, that's _exactly_ the one thing a maintainer should do. Most 
"non-bikeshed-painting" issues don't need maintainers. They are obvious to 
everybody, and/or there's only one person who actually did the work, and 
nobody else ends up beign competent enough, and people know it.

The real glory of maintainership isn't making the big and important 
decisions. The real glory lies in all the _small_ stuff that doesn't 
really matter, and that people will just argue forever.

The ability to just cut off the stupid debate early about something that 
otherwise never gets resolved (or that causes bad feelings just because 
people get worked up over some perceived issue), _that_ is what the 
maintainer is all about.

			Linus
