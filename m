From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: LCA06 Cogito/GIT workshop - (Re: git-whatchanged: exit out early
 on errors)
Date: Fri, 27 Jan 2006 23:47:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 28 05:47:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2hzv-0004LY-66
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 05:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWA1Erg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 23:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWA1Erf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 23:47:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751589AbWA1Erf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2006 23:47:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0S4lTDZ001974
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 Jan 2006 20:47:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0S4lQDo024980;
	Fri, 27 Jan 2006 20:47:27 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15189>



On Thu, 26 Jan 2006, Martin Langhoff wrote:
> 
> During the presentation someone mentioned errors when running
> git-cvsimport which I'm keen on hearing more about.

Martin, I talked to Keith, and apparently you fixed some cvsimport problem 
they had with Cairo during dinner last night? Was that something that 
could have affected other people, or was it very specific to whatever 
Cairo CVS insanity? I've not seen any messages from you on it..

		Linus
