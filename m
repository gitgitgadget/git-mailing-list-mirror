From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] log-tree: show_log() should respect the setting of diffopt->line_termination
Date: Mon, 07 Aug 2006 12:38:40 -0700
Message-ID: <7vy7u01glb.fsf@assigned-by-dhcp.cox.net>
References: <20060807115000.GC15477@h4x0r5.com>
	<1154952684908-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 07 21:39:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAAw1-0008DK-5m
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 21:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWHGTim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 15:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWHGTim
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 15:38:42 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12789 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932263AbWHGTil (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 15:38:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807193841.MDYP6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 15:38:41 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <1154952684908-git-send-email-ryan@michonline.com> (Ryan
	Anderson's message of "Mon, 7 Aug 2006 05:11:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25033>

Thanks.  This indeed was a regression from 1.0 codebase.
