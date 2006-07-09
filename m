From: Junio C Hamano <junkio@cox.net>
Subject: Re: Re : [RFC] just an (stupid) idea when creating a new branch
Date: Sun, 09 Jul 2006 03:16:07 -0700
Message-ID: <7v8xn3nkwo.fsf@assigned-by-dhcp.cox.net>
References: <1152415640.2103.10.camel@dv>
	<20060709094808.74906.qmail@web25811.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 12:16:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzWKm-0006Jl-9W
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 12:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWGIKQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 06:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWGIKQM
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 06:16:12 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42915 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965000AbWGIKQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 06:16:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060709101611.NMKC6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 06:16:11 -0400
To: moreau francis <francis_moreau2000@yahoo.fr>
In-Reply-To: <20060709094808.74906.qmail@web25811.mail.ukl.yahoo.com> (moreau
	francis's message of "Sun, 9 Jul 2006 09:48:08 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23542>

moreau francis <francis_moreau2000@yahoo.fr> writes:

>  I don't know how it works, but see the set of
>  patchs like:
>  
>  [PATCH 0/3] Summary of the set
>                      |
>                     + [PATCH 1/4] blababla
>                      + [PATCH 2/4] another useful commit
>                     + [PATCH 3/4] ...
>  
>  would be great !

Doing the cover letter is primarily a job of the patch
submitter, and I think git-send-email has some support for that.
