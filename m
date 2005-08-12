From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add "--sign" option to git-format-patch-script
Date: Fri, 12 Aug 2005 08:34:51 -0700
Message-ID: <7vr7czxj6s.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508121532051.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 17:36:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3bYd-0007RC-ID
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 17:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVHLPex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 11:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVHLPex
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 11:34:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:18604 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751102AbVHLPew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 11:34:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812153452.WDUP12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 11:34:52 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508121532051.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 12 Aug 2005 15:32:42 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Good intentions, but I'd rather see these S-O-B lines in the
actual commit objects.  Giving format-patch this option would
discourage people to do so.  Maybe a patch to git commit would
be more appropriate, methinks.
