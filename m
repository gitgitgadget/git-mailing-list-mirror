From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 5 Aug 2007 11:23:00 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708051118590.5037@woody.linux-foundation.org>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr>
 <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com>
 <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com>
 <20070804091249.GA17821@uranus.ravnborg.org> <46B45B1E.5020104@midwinter.com>
 <85zm17h4pn.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
 <85myx7dwb3.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org>
 <85bqdndqgr.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708042127160.5037@woody.linux-foundation.org>
 <85bqdmctcl.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708051004480.5037@woody.linux-foundation.org>
 <85bqdlj1lh.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:24:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHkmE-0004Qg-U8
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 20:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbXHESY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 14:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbXHESY2
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 14:24:28 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46182 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751327AbXHESY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 14:24:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75IN5PB001994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Aug 2007 11:23:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75IN0oh020157;
	Sun, 5 Aug 2007 11:23:00 -0700
In-Reply-To: <85bqdlj1lh.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.219 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55052>



On Sun, 5 Aug 2007, David Kastrup wrote:
> 
> You are still unable to focus on anything but name-calling and editors
> rather than documentation formats.

No, it's the same thing.

I started out by saying that Texinfo is horrible. It's horrible because it 
doesn't *buy* you anything. The only thing it buys you (the "info" format) 
is totally irrelevant, which I tried to explain.

AsciiDoc is much nicer. It does everything that Texinfo does for us, and 
it's readable on its own as plain text, something Texinfo isn't.

So by advocating Texinfo, you're advocating something that is OBJECTIVELY 
WORSE than what we have now.

And I tried to explain why, by pointing out that info files (which was the 
case you tried to push as an advantage) aren't actually an advantage to 
any normal user.

			Linus
