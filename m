From: Junio C Hamano <junkio@cox.net>
Subject: Re: Should we support Perl 5.6?
Date: Mon, 20 Feb 2006 13:15:16 -0800
Message-ID: <7v1wxxd95n.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060220191011.GA18085@hand.yhbt.net> <43FA2E46.2000503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 22:15:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBINQ-00026T-7u
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 22:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWBTVPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 16:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWBTVPV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 16:15:21 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:57554 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932498AbWBTVPU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 16:15:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220211244.IJR17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 16:12:44 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43FA2E46.2000503@op5.se> (Andreas Ericsson's message of "Mon, 20
	Feb 2006 22:01:58 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16501>

Andreas Ericsson <ae@op5.se> writes:

> I think we agreed not to bother at all with Perl 5.4 and earlier, and
> not to bend over backwards to support 5.6. This seems like a simple
> fix though, so I'm sure Junio will accept a patch.

Correct.  I wasn't being careful enough.
