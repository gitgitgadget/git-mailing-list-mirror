From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Handle symlinks graciously
Date: Mon, 26 Dec 2005 18:33:53 -0800
Message-ID: <7v8xu7feum.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512262231350.21076@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 03:34:39 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Er4fX-0002Zv-6O
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 03:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVL0Cd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 21:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVL0Cd4
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 21:33:56 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:920 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932143AbVL0Cdz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 21:33:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051227023312.WGGM3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Dec 2005 21:33:12 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512262231350.21076@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 26 Dec 2005 22:31:42 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14069>

Good catch; thanks.
