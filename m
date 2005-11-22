From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-rc2 tag
Date: Tue, 22 Nov 2005 12:01:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511221200340.13959@g5.osdl.org>
References: <20051121212549.GA23213@fieldses.org> <20051122193418.GC5628@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 21:04:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeeKT-0004vl-5s
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 21:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbVKVUBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 15:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVKVUBT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 15:01:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965163AbVKVUBS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 15:01:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAMK1DnO007473
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 22 Nov 2005 12:01:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAMK19RA025384;
	Tue, 22 Nov 2005 12:01:11 -0800
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20051122193418.GC5628@fieldses.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12571>



On Tue, 22 Nov 2005, J. Bruce Fields wrote:
>
> I'm still not getting a 2.6.15-rc2 tag with either git-clone or
> git-fetch --tags.  Any ideas?  Is the problem with me or with the
> repository?

Try using 

  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

instead. Does that help? 

I don't understand how http:// works (or doesn't), so..

		Linus
