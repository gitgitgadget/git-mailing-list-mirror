From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: author/commit counts
Date: Fri, 22 Dec 2006 20:44:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612222038570.3671@woody.osdl.org>
References: <20061222181030.d733deb3.rdunlap@xenotime.net>
 <20061223023719.GA8734@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Randy Dunlap <rdunlap@xenotime.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 05:44:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxykD-0000oH-U8
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 05:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbWLWEoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 23:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWLWEoW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 23:44:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39913 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbWLWEoV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 23:44:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBN4iG2J010249
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Dec 2006 20:44:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBN4iFbr007527;
	Fri, 22 Dec 2006 20:44:15 -0800
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061223023719.GA8734@spearce.org>
X-Spam-Status: No, hits=-0.652 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35262>



On Fri, 22 Dec 2006, Shawn Pearce wrote:
> 
> Here's another variant showing the top 20 committers to git.git,
> no Perl involved:

This is what I've done a few times. For the kernel, I actually find the 
"Signed-off-by:" lines to be more relevant to me (since it shows a 
combination of authorship and maintainership, something that I value a lot 
personally), but I've done statistics on both authors and signers-off )and 
committers, but that mainly just shows who uses git to sync and who does 
not), and I've never written any real scripts for it, I just end up doing 
it with some one-liner shell thing using grep, cut, sort and uniq.

		Linus
