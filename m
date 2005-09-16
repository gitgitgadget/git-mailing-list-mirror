From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shell quoting
Date: Fri, 16 Sep 2005 12:20:16 -0700
Message-ID: <7vfys4izv3.fsf@assigned-by-dhcp.cox.net>
References: <43290BB8.90501@zytor.com>
	<7vy85yahjk.fsf@assigned-by-dhcp.cox.net> <4329C11A.1040302@zytor.com>
	<Pine.LNX.4.58.0509151153140.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 21:22:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGLl6-000164-2J
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVIPTUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVIPTUV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:20:21 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:2779 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751239AbVIPTUU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:20:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916192017.WYMR9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 15:20:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509151153140.26803@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 15 Sep 2005 12:01:17 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8708>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio's "sq_quote()" works wonderfully on any valid shells.

I cannot take credit for that one -- I just picked it up from my
mentor.
