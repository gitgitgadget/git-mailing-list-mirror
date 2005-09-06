From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Tue, 6 Sep 2005 00:59:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509060057491.4316@evo.osdl.org>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0509050738340.3504@evo.osdl.org> <46a038f90509051713389c62c8@mail.gmail.com>
 <Pine.LNX.4.58.0509060013520.4316@evo.osdl.org> <7vll2atz8a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 09:59:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECYMO-0004LK-Oy
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 09:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVIFH7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 03:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbVIFH7E
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 03:59:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964772AbVIFH7C (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 03:59:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j867wlBo005936
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Sep 2005 00:58:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j867wiRj022396;
	Tue, 6 Sep 2005 00:58:45 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll2atz8a.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8126>



On Tue, 6 Sep 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > The point is, naming things as being "scripts" is useful. Grep is just an 
> > example. Naming things as being ".pl" or ".sh" is _not_ useful.
> 
> Sorry, but why not?

What's the upside?

I can point to one downside: "git". That script right now is simple. If 
you rewrite git-cvsimport-script from shell to perl, it looks the same to 
git. 

		Linus
