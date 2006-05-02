From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 02 May 2006 02:01:54 -0700
Message-ID: <7vy7xkn6kd.fsf@assigned-by-dhcp.cox.net>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
	<e34bdf$ho4$1@sea.gmane.org> <7vhd4as00i.fsf@assigned-by-dhcp.cox.net>
	<e34cb4$is1$1@sea.gmane.org> <44571967.7080807@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 11:02:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Faqla-0003lX-R9
	for gcvg-git@gmane.org; Tue, 02 May 2006 11:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWEBJB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 05:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWEBJB4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 05:01:56 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58309 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932522AbWEBJBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 05:01:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502090155.DENP17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 05:01:55 -0400
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44571967.7080807@op5.se> (Andreas Ericsson's message of "Tue, 02
	May 2006 10:33:43 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19411>

Andreas Ericsson <ae@op5.se> writes:

> "git grip" work just fine for me, since it's only intended for testing
> and performance improvements so far. I also think it's clearer for
> end-users looking for a grep command if they're not faced with
> fgrep/egrep/ggrep/bgrep alongside plain "grep".

I renamed "git grip" to "git grep" and "git diffn" to "git diff"
both in "next" branch to avoid confusion.  Thanks Andreas,
Jakub, and others for input.
