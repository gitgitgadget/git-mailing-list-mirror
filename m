From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix buffer overflow in ce_flush().
Date: Sun, 11 Sep 2005 10:53:13 -0700
Message-ID: <7vd5nftrsm.fsf@assigned-by-dhcp.cox.net>
References: <20050911132747.GA26401@mayhq.zapto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 19:53:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEW15-00070S-HQ
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 19:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVIKRxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 13:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVIKRxP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 13:53:15 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:8581 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964988AbVIKRxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 13:53:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911175315.ECRD2438.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 13:53:15 -0400
To: Qingning Huo <qhuo@mayhq.co.uk>
In-Reply-To: <20050911132747.GA26401@mayhq.zapto.org> (Qingning Huo's message
	of "Sun, 11 Sep 2005 14:27:47 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8306>

Thanks, will apply.
