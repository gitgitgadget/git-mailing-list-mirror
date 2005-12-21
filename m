From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with the dump HTTP transport
Date: Wed, 21 Dec 2005 11:14:12 -0800
Message-ID: <7vbqzab6uz.fsf@assigned-by-dhcp.cox.net>
References: <1135166574.26233.64.camel@localhost>
	<7vu0d2baaq.fsf@assigned-by-dhcp.cox.net>
	<1135190585.14627.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 20:14:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep9Po-0003Cp-KK
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 20:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVLUTOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 14:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVLUTOR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 14:14:17 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:4312 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751201AbVLUTOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 14:14:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221191208.RSPO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 14:12:08 -0500
To: Marcel Holtmann <marcel@holtmann.org>,
	Peter Baumann <peter.baumann@gmail.com>,
	merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <1135190585.14627.9.camel@localhost> (Marcel Holtmann's message
	of "Wed, 21 Dec 2005 19:43:05 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13893>

Marcel Holtmann <marcel@holtmann.org> writes:

> it is still not working. How long does it take on www.kernel.org to
> mirror it from the master.

Thanks for the help.  I managed to reproduce it, so I can see
where it breaks.
