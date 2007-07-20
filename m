From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 08:31:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707200827270.27249@woody.linux-foundation.org>
References: <858x9ez1li.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com>
 <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com>
 <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org>
 <7vir8f24o2.fsf@assigned-by-dhcp.cox.net> <85sl7jty43.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	"Shawn O.Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 18:10:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBv3t-0007ie-9O
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 18:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765868AbXGTPbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 11:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755922AbXGTPbx
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 11:31:53 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42583 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765595AbXGTPbw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 11:31:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6KFVPOR015004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 08:31:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6KFVIn2003145;
	Fri, 20 Jul 2007 08:31:19 -0700
In-Reply-To: <85sl7jty43.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.202 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53098>



On Fri, 20 Jul 2007, David Kastrup wrote:
> 
> Like "." destroyed the fundamental concepts of Unix filesystems.

David, I'd suggest you just be quiet and learn, instead of spouting 
idiotic nonsense.

When Junio talks about fundamental concepts of git, you should sit back, 
relax, and ponder. And maybe realize that the git filesystem isn't a "unix 
filesystem". It's a content-addressable one, it's not POSIX, and yes, it 
really does have totally different fundamental concepts.

So your arguments are just inane and stupid, and show that you aren't 
worth discussing with, because you don't even understand what you are 
talking about.

So here's a suggestion: how about trying to *understand* git first. After 
that, you can talk.

In fact, at this point, I have an even better suggestion: how about you 
just shut the hell up until you have a tested patch? Code talks, bullshit 
walks. And right now you are nothing but bullshit.

		Linus
