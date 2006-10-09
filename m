From: Ryan Anderson <ryan@michonline.com>
Subject: Re: perhaps time to remove git_blame from gitweb, and git-annotate?
Date: Mon, 9 Oct 2006 03:37:18 -0700
Message-ID: <20061009103710.GX1558@h4x0r5.com>
References: <7vejtnij5n.fsf@assigned-by-dhcp.cox.net> <20061005064817.21552.qmail@web31804.mail.mud.yahoo.com> <7vu02jfaec.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	Ryan Anderson <ryan@michonline.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 09 12:38:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWsW4-0006Oq-7E
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 12:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWJIKhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 06:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWJIKhp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 06:37:45 -0400
Received: from h4x0r5.com ([70.85.31.202]:35857 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751267AbWJIKho (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Oct 2006 06:37:44 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1GWsVa-0001Ub-Ox; Mon, 09 Oct 2006 03:37:19 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu02jfaec.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28568>

On Thu, Oct 05, 2006 at 01:13:15AM -0700, Junio C Hamano wrote:
> It's been a while since we lost git_blame from %actions list.  I
> am wondering maybe it's time to remove it, after 1.4.3 happens.

I certainly have no objection.  In fact, I sent a patch a moment ago.
(I didn't keep the cc: on it, I figured there was too high a chance of
mishap when pasting the cc: list.)

I forgot to mentio it in the email, but I have the change pullable from:
http://h4x0r5.com/~ryan/git/ryan.git/ del-annotate
(and gitwebed from http://h4x0r5.com/~ryan/gitweb.cgi )
-- 

Ryan Anderson
  sometimes Pug Majere
