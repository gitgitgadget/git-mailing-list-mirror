From: Junio C Hamano <junkio@cox.net>
Subject: Re: Summary of core GIT while you are away.
Date: Wed, 25 May 2005 18:13:58 -0700
Message-ID: <7vzmuig561.fsf@assigned-by-dhcp.cox.net>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>
	<20050526004411.GA12360@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 03:12:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db6v2-0007xH-Hh
	for gcvg-git@gmane.org; Thu, 26 May 2005 03:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVEZBOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 21:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVEZBOE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 21:14:04 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55462 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261644AbVEZBOB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 21:14:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526011359.FEEA22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 21:13:59 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050526004411.GA12360@vrfy.org> (Kay Sievers's message of
 "Thu, 26 May 2005 02:44:11 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

KS> What happened to that idea? That's not already working in some other way I
KS> missed, right? The pickaxe stuff is nice and was easy to call from the cgi,
KS> but searching in commit messages would be nice too.
KS> If it's not going to happen in the git-binaries, I may do it just in the
KS> cgi itself.

I haven't done anything about this yet.  I was kind of waiting
for the blob retention API for "struct object" derivatives to
come to the conclusion.


