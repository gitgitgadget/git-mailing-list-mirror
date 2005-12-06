From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Mon, 05 Dec 2005 23:31:41 -0800
Message-ID: <7vk6ei65r6.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	<81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	<7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	<7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
	<20051205215059.GC4443@steel.home>
	<7vr78r9pg0.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512052315p1917a04ek264c14abf41a1027@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 08:33:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjXIg-0007MY-Fo
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 08:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVLFHbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 02:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVLFHbn
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 02:31:43 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62396 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751463AbVLFHbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 02:31:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206073056.DMAC6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 02:30:56 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512052315p1917a04ek264c14abf41a1027@mail.gmail.com>
	(Alex Riesen's message of "Tue, 6 Dec 2005 08:15:16 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13260>

Alex Riesen <raa.lkml@gmail.com> writes:

> ... return MAP_FAILED if error, do not
> exit process, do no output.

Ah, that is what you meant.  I agree.
