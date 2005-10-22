From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling renames.
Date: Fri, 21 Oct 2005 20:23:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510212022100.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
 <20051022003733.GA8351@pasky.or.cz> <20051022004743.GN30889@pasky.or.cz>
 <Pine.LNX.4.64.0510211826350.10477@g5.osdl.org> <20051022015109.GO30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 05:24:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET9z4-0001r9-Dc
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 05:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVJVDXr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 23:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVJVDXr
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 23:23:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932577AbVJVDXq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 23:23:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9M3NcFC029903
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Oct 2005 20:23:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9M3NaDB001354;
	Fri, 21 Oct 2005 20:23:37 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051022015109.GO30889@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10465>



On Sat, 22 Oct 2005, Petr Baudis wrote:
> 
> > You can follow renames _afterwards_. 
> 
> I can - crudely, but what's the point, if the user is dying to give me
> the information.

No the user is NOT.

The fact is, users have not a frigging clue when a rename happens. 

I told you before, I'll tell you again: if you depend on users telling you 
about renames, you'll get it wrong. You'll get it wrong quite often, in 
fact.

This is not something I'm going to discuss again. Go back to all the same 
arguments from 6 months ago. I was right then, I'm right now.

		Linus
