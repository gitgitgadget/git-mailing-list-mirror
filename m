From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -d flag to git-pull-* family.
Date: Wed, 01 Jun 2005 09:00:59 -0700
Message-ID: <7vpsv6kqx0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
	<7vacmapo18.fsf@assigned-by-dhcp.cox.net>
	<7vu0kilc21.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0506011032570.7439@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:03:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdVeH-00007S-IQ
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 18:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVFAQDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 12:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVFAQCD
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 12:02:03 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13526 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261448AbVFAQBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 12:01:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601160101.LHAH7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 12:01:01 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0506011032570.7439@localhost.localdomain> (Nicolas
 Pitre's message of "Wed, 01 Jun 2005 10:39:25 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> What do you think?

What you say makes a lot more sense than my quick hack on both
counts.

