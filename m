From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-checkout: disable guides how to switch branches with ui.guide
Date: Thu, 1 Feb 2007 21:51:45 +0100
Message-ID: <20070201205145.GA13439@moooo.ath.cx>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <Pine.LNX.4.64.0701311907500.3021@xanadu.home> <20070201030030.GA1979@coredump.intra.peff.net> <7vd54ur26u.fsf@assigned-by-dhcp.cox.net> <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net> <20070201184403.GA6326@moooo.ath.cx> <7vabzxpq2t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 21:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCiuP-00005u-MQ
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 21:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423002AbXBAUvu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 15:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423004AbXBAUvu
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 15:51:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:42406 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423002AbXBAUvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 15:51:50 -0500
Received: (qmail invoked by alias); 01 Feb 2007 20:51:48 -0000
Received: from pD9EB9AC1.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.154.193]
  by mail.gmx.net (mp033) with SMTP; 01 Feb 2007 21:51:48 +0100
X-Authenticated: #5358227
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vabzxpq2t.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38396>

Junio C Hamano <junkio@cox.net> wrote:
> The original hope was after a few times one would know to use
> either -f or -b depending on what he wants, and would not run
> plain vanilla branch switching "git checkout master".
What is the point in detached heads if the user should start using -b
after a few times?  I think detached heads are useful, so I will not
use -b with it.
