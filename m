From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fix interrupted squashing
Date: Fri, 27 Jul 2007 12:20:39 -0700
Message-ID: <7v1wet1wmw.fsf@assigned-by-dhcp.cox.net>
References: <20070723225402.GB22513@informatik.uni-freiburg.de>
	<Pine.LNX.4.64.0707240005240.14781@racer.site>
	<20070724200510.GA27610@informatik.uni-freiburg.de>
	<Pine.LNX.4.64.0707242139370.14781@racer.site>
	<Pine.LNX.4.64.0707271817100.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:20:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVMo-0006II-PJ
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758445AbXG0TUq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759754AbXG0TUq
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:20:46 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52446 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbXG0TUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:20:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727192041.ENFT1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 15:20:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UjLg1X0011kojtg0000000; Fri, 27 Jul 2007 15:20:40 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53953>

Thanks for reminding.

I thought I read the patch, felt satisfied and already applied,
but obviously I forgot the last step.  Anything else that should
be in 1.5.3 I forgot?

BTW, I _think_ somebody between your brain and my mbox mangled
umlaut in Uwe's name.  I'll fix it up.
