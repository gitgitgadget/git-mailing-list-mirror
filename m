From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 19] gitweb: No need to quote path for list version of open "-|"
Date: Mon, 31 Jul 2006 11:55:23 -0700
Message-ID: <7v3bch7gf8.fsf@assigned-by-dhcp.cox.net>
References: <200607292239.11034.jnareb@gmail.com>
	<200607311833.39524.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 20:55:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7cvJ-0006MC-0X
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 20:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWGaSzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 14:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWGaSzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 14:55:25 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42724 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751085AbWGaSzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 14:55:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731185524.TVIZ1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 14:55:24 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200607311833.39524.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 31 Jul 2006 18:33:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24537>

I suspect the patch title is wrong -- it is not "no need to" but
"quoting path breaks so do not do it" ;-).

I guess this fixes the problem I saw last night?
