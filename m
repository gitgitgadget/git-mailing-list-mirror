From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Mon, 10 Jul 2006 00:47:49 -0700
Message-ID: <7vsll9dhp6.fsf@assigned-by-dhcp.cox.net>
References: <20060708183402.GA17644@spearce.org>
	<7vy7v4orpt.fsf@assigned-by-dhcp.cox.net>
	<20060708190327.GA17763@spearce.org>
	<20060709073155.GP22573@lug-owl.de>
	<20060710052255.GA15173@spearce.org> <1152512523.3504.28.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 09:47:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzqUk-00049D-Jc
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 09:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWGJHrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 03:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGJHrw
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 03:47:52 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37086 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751252AbWGJHrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 03:47:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710074750.XWBB22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 03:47:50 -0400
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23601>

Pavel Roskin <proski@gnu.org> writes:

> I think it's fair that we fix this incompatibility.  It's very
> very minor compared to what "gcc -std=c89 -pedantic" would
> have required.

I think I agree with you.  Let's have it in.
