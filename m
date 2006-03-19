From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added Packing Heursitics IRC writeup.
Date: Sat, 18 Mar 2006 18:46:17 -0800
Message-ID: <7vr74zqhhi.fsf@assigned-by-dhcp.cox.net>
References: <E1FEyx7-0007vo-Je@jdl.com>
	<20060319003255.GA17124@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org, Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Sun Mar 19 03:46:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKnvz-0000jq-QU
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 03:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWCSCqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 21:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWCSCqU
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 21:46:20 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48583 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751298AbWCSCqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 21:46:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060319024240.UIAP17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Mar 2006 21:42:40 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060319003255.GA17124@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 19 Mar 2006 01:32:56 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17707>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> [nice description of Git's packing heuristics]
>
> Junio, are there any specific reasons why this hasn't been applied
> yet?

Funny.  I was just re-reading it last night.

It _is_ amusing, but I am not sure if it should go to
technical/.  If properly digested and reorganized, I suspect
that the document would become 1/3 of its current length.
