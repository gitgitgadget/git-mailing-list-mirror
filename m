From: Pavel Roskin <proski@gnu.org>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Sat, 29 Oct 2005 00:54:00 -0400
Message-ID: <20051029005400.s1ge8c4ok0wo4s4s@webmail.spamcop.net>
References: <1130434230.19641.21.camel@dv>
	<7vslum3l2w.fsf@assigned-by-dhcp.cox.net> <1130463389.2186.14.camel@dv>
	<7v4q72xavz.fsf@assigned-by-dhcp.cox.net> <1130539503.10531.43.camel@dv>
	<7vslul2g29.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510282003360.3348@g5.osdl.org>
	<20051029002357.iq88cg8gcsogk4kc@webmail.spamcop.net>
	<Pine.LNX.4.64.0510282132120.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 06:55:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVijG-0000XH-C7
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVJ2EyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVJ2EyC
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:54:02 -0400
Received: from c62.cesmail.net ([216.154.195.54]:57764 "EHLO c62.cesmail.net")
	by vger.kernel.org with ESMTP id S1751144AbVJ2EyA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Oct 2005 00:54:00 -0400
Received: from unknown (HELO gamma.cesmail.net) ([192.168.1.20])
  by c62.cesmail.net with SMTP; 29 Oct 2005 00:54:00 -0400
Received: (qmail 10183 invoked by uid 99); 29 Oct 2005 04:54:00 -0000
Received: from static-68-161-241-229.ny325.east.verizon.net
	(static-68-161-241-229.ny325.east.verizon.net [68.161.241.229]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Sat, 29 Oct 2005 00:54:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510282132120.3348@g5.osdl.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10793>

Quoting Linus Torvalds <torvalds@osdl.org>:

> On Sat, 29 Oct 2005, Pavel Roskin wrote:
> >
> > I understand the default behavior of git-diff-tree won't change, so I'll
> simply
> > strip the first line.
>
> Be careful, though. The merge case uses git-diff-tree differently, so I
> think there is no extra line for a merge.

Sure.  Thanks.

--
Regards,
Pavel Roskin
