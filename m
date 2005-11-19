From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Sat, 19 Nov 2005 11:52:54 -0800
Message-ID: <7vzmo04dpl.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	<Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>
	<cda58cb80511170236p4a7e2baay@mail.gmail.com>
	<Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
	<cda58cb80511171347yef4f090g@mail.gmail.com>
	<Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
	<cda58cb80511190423w1e46bf5bu@mail.gmail.com>
	<Pine.LNX.4.64.0511190953520.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Franck <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 20:53:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdYlh-00036G-OL
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 20:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVKSTw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 14:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVKSTw5
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 14:52:57 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45530 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750765AbVKSTw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 14:52:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119195141.LUWV17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 14:51:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511190953520.13959@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 19 Nov 2005 09:56:59 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12348>

Linus Torvalds <torvalds@osdl.org> writes:

> So "git repack" should _never_ call git-redundant-pack. It's always either 
> wrong or pointless.

Right-o.
