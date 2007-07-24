From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: workflow question
Date: Tue, 24 Jul 2007 14:38:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707241433360.3607@woody.linux-foundation.org>
References: <e2a1d0aa0707240653x55dd82b3pf9e3986f5c3bb344@mail.gmail.com>
 <81b0412b0707240837l16844dbct52ffa426d8b8547b@mail.gmail.com>
 <e2a1d0aa0707240930gb99cb0csd1ce9946d33982d@mail.gmail.com>
 <20070724205702.GD6004@steel.home> <20070724210024.GC5040@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Patrick Doyle <wpdster@gmail.com>, git <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:39:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDS6E-0007mc-4t
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 23:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbXGXVjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 17:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbXGXVjT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 17:39:19 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39449 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753167AbXGXVjS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 17:39:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6OLcuxg022795
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jul 2007 14:38:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6OLcoIn002217;
	Tue, 24 Jul 2007 14:38:50 -0700
In-Reply-To: <20070724210024.GC5040@fieldses.org>
X-Spam-Status: No, hits=-2.728 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53650>



On Tue, 24 Jul 2007, J. Bruce Fields wrote:
> 
> (Also, as a quick fix, note that ctrl-- and ctrl-= will adjust the font
> size down or up (respectively).)

Side note: this can be *really* confusing on non-US keyboards.

The "=" makes sense on a US keyboard, because it's really "ctrl-+" without 
the added need to press "shift".

On many non-US keyboards, there is no such arrangement of +/= on the 
keyboard.

So on a Finnish keyboard, for example, the sequence to make the fonts 
smaller is "ctrl--", but the sequence to make them larger is 
"contr-shift-0". Which makes *no* sense what-so-ever, but the "=" sign is 
"shift-0".

Oh, well. On a Finnish keyboard, "ctrl-+" would make tons of sense. I 
always try it, and am frustrated when it doesn't work.

			Linus
