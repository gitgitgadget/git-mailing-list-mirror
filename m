From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] When copying or renaming, keep the mode, please
Date: Wed, 17 Aug 2005 00:32:07 -0700
Message-ID: <7v7jel10js.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508170900420.3236@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 09:32:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5IPN-0003no-3i
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 09:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVHQHcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 03:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVHQHcK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 03:32:10 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:40067 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750923AbVHQHcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 03:32:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817073207.GLUY19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 03:32:07 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508170900420.3236@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 17 Aug 2005 09:01:07 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Good catch.  Thanks.
