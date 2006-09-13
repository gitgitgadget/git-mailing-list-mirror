From: Junio C Hamano <junkio@cox.net>
Subject: Re: problem with http clone/pull
Date: Wed, 13 Sep 2006 12:03:28 -0700
Message-ID: <7v7j07a8sf.fsf@assigned-by-dhcp.cox.net>
References: <17671.16741.995661.664789@cargo.ozlabs.ibm.com>
	<7vodtkejm9.fsf@assigned-by-dhcp.cox.net>
	<7v7j08eikw.fsf@assigned-by-dhcp.cox.net>
	<17671.23044.481280.965798@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 21:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNa1E-0007Rd-4g
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 21:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWIMTD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 15:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWIMTD3
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 15:03:29 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27836 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750889AbWIMTD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 15:03:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913190328.NZEO2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 15:03:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mv3J1V0071kojtg0000000
	Wed, 13 Sep 2006 15:03:18 -0400
To: git@vger.kernel.org
In-Reply-To: <17671.23044.481280.965798@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Wed, 13 Sep 2006 11:08:20 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26934>

I'll do 1.4.2.1 with a fix for this and push it out hopefully
today.
