From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cogito documentation updates
Date: Wed, 23 Nov 2005 11:52:35 -0800
Message-ID: <7voe4b3zwc.fsf@assigned-by-dhcp.cox.net>
References: <20051120101112.GA2302@diku.dk>
	<86veyn49gc.fsf@blue.stonehenge.com> <20051123121651.GB19302@diku.dk>
	<8664qjph7d.fsf@blue.stonehenge.com> <438483A4.6040802@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 20:53:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef0ff-000621-No
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 20:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVKWTwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 14:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVKWTwi
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 14:52:38 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:32390 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932266AbVKWTwh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 14:52:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123195209.UILE3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 14:52:09 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <438483A4.6040802@op5.se> (Andreas Ericsson's message of "Wed, 23
	Nov 2005 15:58:44 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12647>

Andreas Ericsson <ae@op5.se> writes:

> I'm not Junio, but I think the priorities right now are ordererd like 
> this; good performance, fast development, portability.

I am, but I am not Pasky, so I cannot talk about priority of
Cogito.

> However, most of the plumbing works on just about anything with a CPU, 
> so unless you really need cg-clone you should be able to do it with 
> git-clone, which AFAIU uses 'tar' and 'cpio' instead of cp to transfer 
> files (for portability reasons, I imagine).

Exactly, because people with portability problems tend to feed
good patches directly to me and to the list.
