From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 09:59:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr>
 <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com>
 <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com>
 <20070804091249.GA17821@uranus.ravnborg.org> <46B45B1E.5020104@midwinter.com>
 <85zm17h4pn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMzn-0001PZ-0b
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760644AbXHDRAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759060AbXHDRAw
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:00:52 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56938 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754124AbXHDRAv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 13:00:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l74GxEJA010699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Aug 2007 09:59:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l74Gx8vo002171;
	Sat, 4 Aug 2007 09:59:08 -0700
In-Reply-To: <85zm17h4pn.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54884>



On Sat, 4 Aug 2007, David Kastrup wrote:
> 
> A system such as info, in contrast, is hierarchical, and organized
> with indexes and cross references making it much easier to find
> things.

You must be kidding. Texinfo is the worst documentation format EVER. And 
the readers universally suck too, unless you're a total GNU emacs fan and 
have been for a decade, and have problems understanding people who don't 
like the all-in-one mentality.

There are absolutely _zero_ advantages in Texinfo over AsciiDoc. It has 
all the same disadvantages, except the source files are *also* unreadable 
(which is the one really nice feature of AsciiDoc - you can ignore 
everything else, and just read the original .txt file).

			Linus
