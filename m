From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem merging
Date: Wed, 23 Nov 2005 11:48:20 -0800
Message-ID: <7vsltn403f.fsf@assigned-by-dhcp.cox.net>
References: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com>
	<20051123085953.GA4933@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 20:51:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef0bR-000473-7o
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 20:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVKWTsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 14:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVKWTsW
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 14:48:22 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42231 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932256AbVKWTsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 14:48:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123194701.BORN17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 14:47:01 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051123085953.GA4933@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Wed, 23 Nov 2005 09:59:53 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12646>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> Have you tried this merge with the recursive merge strategy?
>
> Btw is there a reason why 'recursive' isn't the default merge strategy
> for git-merge? It might be a bit confusing that git-pull and git-merge
> have different default strategies...

Agreed; will patch.
