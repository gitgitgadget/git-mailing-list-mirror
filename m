From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] gitweb: Show snapshot links for tree entries in tree listing
Date: Sat, 07 Oct 2006 15:31:11 -0700
Message-ID: <7vr6xjpxlc.fsf@assigned-by-dhcp.cox.net>
References: <20061007184148.GE20017@pasky.or.cz>
	<20061007185253.90045.qmail@web31810.mail.mud.yahoo.com>
	<20061007191552.GG20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 00:31:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWKhS-0003BP-Mm
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 00:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbWJGWbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 18:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWJGWbN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 18:31:13 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64995 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751834AbWJGWbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 18:31:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007223111.FLWE12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 18:31:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XaXE1V00A1kojtg0000000
	Sat, 07 Oct 2006 18:31:14 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061007191552.GG20017@pasky.or.cz> (Petr Baudis's message of
	"Sat, 7 Oct 2006 21:15:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28514>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sat, Oct 07, 2006 at 08:52:53PM CEST, I got a letter
> where Luben Tuikov <ltuikov@yahoo.com> said that...
>> Another thing is that currently tree/directory entries' third (links)
>> column to be shortest of all, and this gives my eyes another indication
>> that this is a tree.
>
> What would people think about first listing all the trees, then all the
> blobs? Just like LANG=C ls does, as well as cvsweb and overally most of
> the rest of the relevant world.

Mildly negative but I do not have strong preference.

BTW, I do not get what you mean by "LANG=C ls".
