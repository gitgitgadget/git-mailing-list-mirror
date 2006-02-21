From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-mktree: reverse of git-ls-tree.
Date: Tue, 21 Feb 2006 09:40:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602210915320.30245@g5.osdl.org>
References: <7vk6bp43qm.fsf@assigned-by-dhcp.cox.net>
 <1140504750.16926.111.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1420118784-1140543606=:30245"
Cc: Junio C Hamano <junkio@cox.net>, Tommi Virtanen <tv@debian.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 18:41:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBbVI-0007CM-Ty
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 18:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWBURkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 12:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWBURkp
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 12:40:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932150AbWBURko (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 12:40:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1LHeADZ030865
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Feb 2006 09:40:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1LHe6Hg027367;
	Tue, 21 Feb 2006 09:40:08 -0800
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1140504750.16926.111.camel@evo.keithp.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16535>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1420118784-1140543606=:30245
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Mon, 20 Feb 2006, Keith Packard wrote:
> 
> > + * Copyright (c) Junio C Hamano, 2006
> 
> I've been told by at least two lawyers that the string '(c)' has no
> legal meaning in the US. If you want to indicate copyright, the only
> symbol which does carry legal weight is the c-in-a-circle mark '©'. 

You should change lawyers, methinks.

The thing is, once the same line says "Copyright", the string '(c)' may be 
meaningless, but more importantly, your lawyers are wasting your time with 
pointless and mindless "punktknulleri" (literal meaning: "the f*cking of 
points", aka being anal retentive).

Of course, they are probably also charging you for that time they are 
wasting, which is why you should fire them and find somebody who tells you 
anything relevant.

The FACT is that
 (a) You can write out the word "copyright" in its entirety.
 (b) the US legal system very much takes intent into account, so even if 
     you don't, if the meaning is clear, it's not like it matters. This
     is even more true on most of the rest of the civilized world, btw (ie 
     Europe in general gives authors _more_ rights than the US, since they 
     recognize the notion of "moral rights")
 (c) you own the copyright anyway ever since 1988, when the US ratified 
     the Berne convention. In fact, even before then, the US had adopted 
     the notion of automatic copyrights, and any work created after 1978 
     falls under this.

Anyway, for more details if you _really_ care, look up "Circular 3" by the 
United States Copyright Office. The very first sentence of that paper 
talks about how the notice isn't even required any more, but if you want 
to talk to your punktknullande lawyers, point them to the section called 
"form of notice". Which mentions the © letter, but makes it very very 
clear that "Copyright" or the abbreviation "Copr." are totally 
interchangeable in the US.

Now, in some _other_ countries, the © mark may be special, but quite 
frankly, you won't really care. If it matters, those countries haven't 
ratified the Berne convention, and you'll never ever in a million years 
care about them. It's absolutely certainly not the case in any relevant 
country.

Any country where "©" matters likely has many bigger problems wrt 
copyrights, like not honoring them at all.

So: if you care about the copyright law in Ulan Bator, you may have to use 
the © character. But the likelihood is that it's not an issue even there.

So tell your lawyers to f*ck the hell off.

		Linus
--21872808-1420118784-1140543606=:30245--
