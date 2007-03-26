From: Junio C Hamano <junkio@cox.net>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 15:51:21 -0700
Message-ID: <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
References: <1174825838.12540.5.camel@localhost>
	<1174930688.5662.20.camel@localhost>
	<20070326183523.GG22773@admingilde.org>
	<200703262133.44520.Josef.Weidendorfer@gmx.de>
	<20070326220302.GH22773@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 00:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVy2B-0003KJ-PV
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 00:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933591AbXCZWvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 18:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933790AbXCZWvX
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 18:51:23 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48146 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933591AbXCZWvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 18:51:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326225123.HXPV748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 18:51:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id farM1W00Z1kojtg0000000; Mon, 26 Mar 2007 18:51:22 -0400
In-Reply-To: <20070326220302.GH22773@admingilde.org> (Martin Waitz's message
	of "Tue, 27 Mar 2007 00:03:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43198>

Martin Waitz <tali@admingilde.org> writes:

> For submodules I currently use <parent>/.git/objects/module/<submodule>/
> to store the objects belonging to the submodule.

I was not following the gitlink discussion closely, but what is
the motivation behind this separation of the object store?
