From: Junio C Hamano <junkio@cox.net>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 13:40:46 -0700
Message-ID: <7vk6lkwgfl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	<20050527192941.GE7068@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	<20050527192941.GE7068@cip.informatik.uni-erlangen.de>
	<7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net>
	<20050527195552.GA6541@cip.informatik.uni-erlangen.de>
	<7vu0kowho9.fsf@assigned-by-dhcp.cox.net>
	<20050527203227.GA11139@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 22:41:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dblbn-0004rN-Bo
	for gcvg-git@gmane.org; Fri, 27 May 2005 22:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVE0UlA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 16:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVE0Uk7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 16:40:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55524 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262582AbVE0Ukv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 16:40:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527204047.FYLI26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 16:40:47 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050527203227.GA11139@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Fri, 27 May 2005 22:32:27 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> But I guess 8 is the limit, isn't it? Did you thought to make this 8 a
TG> 'n' or is 8 just enough? :-)

Built-in limit of commit object is 16, not 8.


