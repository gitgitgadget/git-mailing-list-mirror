From: Junio C Hamano <junkio@cox.net>
Subject: Re: [KORG] kernel.org/git/ showing nothing
Date: Fri, 04 Aug 2006 03:56:11 -0700
Message-ID: <7vk65olqgk.fsf@assigned-by-dhcp.cox.net>
References: <44D3208E.8090403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 12:56:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8xLk-0006nj-Br
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 12:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbWHDK4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 06:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbWHDK4N
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 06:56:13 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8407 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161165AbWHDK4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 06:56:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804105612.KFYS554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 06:56:12 -0400
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <44D3208E.8090403@garzik.org> (Jeff Garzik's message of "Fri, 04
	Aug 2006 06:25:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24786>

Jeff Garzik <jeff@garzik.org> writes:

> When I visit http://www.kernel.org/git/ no projects at all are listed.
>
> At least one other person independently noted this, as well.

DNS round robin -- server at .5 is Ok, .37 seems bad.
