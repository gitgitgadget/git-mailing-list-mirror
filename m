From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] delta creation
Date: Fri, 20 May 2005 22:02:28 -0700
Message-ID: <7vwtptnpcr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0505201659190.4397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 07:02:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZM7X-0001S5-I3
	for gcvg-git@gmane.org; Sat, 21 May 2005 07:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVEUFCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 01:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVEUFCj
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 01:02:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:23694 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261658AbVEUFCc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 01:02:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521050230.XXTT22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 01:02:30 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505201659190.4397@localhost.localdomain> (Nicolas
 Pitre's message of "Fri, 20 May 2005 17:00:23 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just a stupid wording question, but is "deltafy" the word we
want to use?  The other command name "mkdelta" feels more easier
to swallow at least for me ...


