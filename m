From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 22:32:27 +0200
Message-ID: <20050527203227.GA11139@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org> <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net> <20050527195552.GA6541@cip.informatik.uni-erlangen.de> <7vu0kowho9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 22:31:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DblTe-00048h-KL
	for gcvg-git@gmane.org; Fri, 27 May 2005 22:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVE0Ucn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 16:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVE0Ucn
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 16:32:43 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:35516 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262579AbVE0Uch (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 16:32:37 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4RKWRS8012182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2005 20:32:27 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4RKWRDB012181;
	Fri, 27 May 2005 22:32:27 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org> <7vu0kowho9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
okay thanks for the elaboration on the topic. I will now adopt my
scripts to handle it. I think I already have a use for it.

            -- mutt-hcache   --
           /-- mutt-imap     --\
          /--- mutt-whatever ---\
 mutt-cvs ---- ...           ----- mutt-tg (my working tree)
          \    ...           ----/
           \-- ...             -/

Actually, I have already 12 trees with different features which I work on.

 1 mutt-attach-file       5 mutt-hcache            9 mutt-menu-move
 2 mutt-collapse-flags    6 mutt-headers          10 mutt-move-hook
 3 mutt-cstatus           7 mutt-imap             11 mutt-setenv-hack
 4 mutt-edit-threads      8 mutt-maildir-mtime    12 mutt-thread-pattern

But I guess 8 is the limit, isn't it? Did you thought to make this 8 a
'n' or is 8 just enough? :-)

	Thomas
