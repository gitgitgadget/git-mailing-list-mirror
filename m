From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] We do not like "HEAD" as a new branch name
Date: Thu, 15 Dec 2005 22:34:42 -0800
Message-ID: <7v8xullfct.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vacf2p320.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512152339530.4962@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4q5alyms.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512160238300.6530@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 07:35:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En9BG-0008Pq-K9
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 07:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVLPGeo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 01:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVLPGeo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 01:34:44 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:17321 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932149AbVLPGeo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 01:34:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216063405.YWMX3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 01:34:05 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13731>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay. Why not go the full nine yards, and not be difficult about it:

That's fine.  There is an off-by-one in your code, though.
I've committed it with a tweak.
