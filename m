From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Sat, 13 Aug 2005 11:33:00 -0700
Message-ID: <7v8xz5offn.fsf@assigned-by-dhcp.cox.net>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net>
	<20050813120815.GC5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 20:33:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E40oc-0001IA-IA
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 20:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVHMSdD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 14:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVHMSdD
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 14:33:03 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42172 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932247AbVHMSdC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 14:33:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813183301.EXDY19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 14:33:01 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> What about calling it rather info/alternates (or info/alternate)? It
> looks better, sounds better, is more namespace-ecological tab-completes
> fine and you don't type it that often anyway. :-)

Thanks for the suggestion.  Will fix and keep it in the pu
branch for now just in case somebody else suggests a name even
better.
