From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Thu, 28 Sep 2006 09:16:22 -0700
Message-ID: <7v64f8vueh.fsf@assigned-by-dhcp.cox.net>
References: <20060918004831.GA19851@spearce.org>
	<7vodtex9xm.fsf@assigned-by-dhcp.cox.net>
	<20060918011855.GA19955@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 18:17:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSyYm-0003B3-Ps
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWI1QQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWI1QQZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:16:25 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24063 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751732AbWI1QQX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 12:16:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928161623.UXXA12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 12:16:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TsGR1V00j1kojtg0000000
	Thu, 28 Sep 2006 12:16:26 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28015>

Shawn Pearce <spearce@spearce.org> writes:

> I'm not sure there are too many other things to hook into bash in
> addition to completion so contrib/completion/git-completion.bash may
> be the better location, assuming it doesn't graduate out of contrib/.

Just so that we do not forget, I applied this (and your
follow-up patch).
