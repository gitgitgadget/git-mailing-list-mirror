From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config.c: remove unnecessary header in minimum configuration file.
Date: Sun, 04 Dec 2005 16:27:48 -0800
Message-ID: <7vu0docrqz.fsf@assigned-by-dhcp.cox.net>
References: <7v7jawmkpo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 05 01:28:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej4Cw-00025A-1Y
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 01:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVLEA1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 19:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVLEA1v
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 19:27:51 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18637 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932303AbVLEA1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 19:27:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205002700.FRIA20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 19:27:00 -0500
To: git@vger.kernel.org
In-Reply-To: <7v7jawmkpo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 25 Nov 2005 14:22:27 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13205>

Junio C Hamano <junkio@cox.net> writes:

> It is just silly to start the file called "config" with a
> comment that says "This is the config file."

Any likes or dislikes?
