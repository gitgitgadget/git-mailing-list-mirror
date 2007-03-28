From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added configure options --with-tcltk/--without-tcltk.
Date: Tue, 27 Mar 2007 18:52:32 -0700
Message-ID: <7vps6um8wv.fsf@assigned-by-dhcp.cox.net>
References: <etpuen$2uo$2@sea.gmane.org> <20070326073143.GB44578@codelabs.ru>
	<20070326073250.GC44578@codelabs.ru>
	<200703261030.49382.jnareb@gmail.com>
	<7vmz20xuxq.fsf@assigned-by-dhcp.cox.net>
	<20070326100344.GV14837@codelabs.ru>
	<7vejnbtjdq.fsf@assigned-by-dhcp.cox.net>
	<20070327065940.GC51155@codelabs.ru>
	<20070327102437.GM14837@codelabs.ru>
	<7vtzw7nej6.fsf@assigned-by-dhcp.cox.net>
	<20070327110714.GA14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Mar 28 03:52:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWNL4-00082h-5Q
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 03:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXC1Bwe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 21:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbXC1Bwe
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 21:52:34 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33467 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbXC1Bwd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 21:52:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328015232.WKEJ28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 27 Mar 2007 21:52:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id g1sY1W0011kojtg0000000; Tue, 27 Mar 2007 21:52:32 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43341>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

>> I suspect that the change to allow not installing gitk/git-gui
>> and the change to allow using specific "wish" are two
>> independent tasks.
>
> But then the configure will be first teached to recognise only
> '--with-tcltk/--without-tcltk' and the second modification will
> add '--with-tcltk=/path/to/wish', right?

That sounds sensible to me.

Thanks.
