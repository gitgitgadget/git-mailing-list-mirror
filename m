From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read refs
Date: Thu, 21 Sep 2006 21:57:52 -0700
Message-ID: <7vbqp87b1r.fsf@assigned-by-dhcp.cox.net>
References: <20060920085200.GA21865@shadowen.org> <eer19l$6hm$1@sea.gmane.org>
	<4511173D.7020702@shadowen.org>
	<7vodtak00n.fsf@assigned-by-dhcp.cox.net>
	<45116888.4050806@shadowen.org>
	<7vwt7yij12.fsf@assigned-by-dhcp.cox.net>
	<4512804C.8060807@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 06:58:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQd7E-0003J2-Kt
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 06:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWIVE5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 00:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWIVE5y
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 00:57:54 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:21665 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932262AbWIVE5x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 00:57:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060922045753.OPSK26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 00:57:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RGxv1V0091kojtg0000000
	Fri, 22 Sep 2006 00:57:55 -0400
To: Andy Whitcroft <apw@shadowen.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27520>

Andy Whitcroft <apw@shadowen.org> writes:

> ... I've taken the liberty of updating and clarifying the language
> to make it very obvious from the outset that the language specific
> output formats are for generating eval'able snippets and added a simple
> example of it to complement your complex one.
>
> Patch to follow.

Thanks.
