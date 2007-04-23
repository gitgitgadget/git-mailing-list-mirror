From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] dir.c(common_prefix): Fix two bugs
Date: Mon, 23 Apr 2007 02:22:21 -0700
Message-ID: <7vslarh2cy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704231020070.8822@racer.site>
	<7vzm4zh3z7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704231108230.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 11:22:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfukc-0003VF-NB
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 11:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbXDWJWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 05:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbXDWJWW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 05:22:22 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35598 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbXDWJWW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 05:22:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423092222.WRIA1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 23 Apr 2007 05:22:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qZNM1W0041kojtg0000000; Mon, 23 Apr 2007 05:22:21 -0400
In-Reply-To: <Pine.LNX.4.64.0704231108230.8822@racer.site> (Johannes
	Schindelin's message of "Mon, 23 Apr 2007 11:12:26 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45307>

In any case, well spotted, thanks.
