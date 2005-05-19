From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Deltification library work by Nicolas Pitre.
Date: Thu, 19 May 2005 09:59:59 -0700
Message-ID: <7vekc3178w.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpv1pd4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191019180.20274@localhost.localdomain>
	<Pine.LNX.4.58.0505190736020.2322@ppc970.osdl.org>
	<Pine.LNX.4.62.0505191104410.20274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 19:01:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYoMi-0002dB-W6
	for gcvg-git@gmane.org; Thu, 19 May 2005 18:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVESRAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 13:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVESRAF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 13:00:05 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51140 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261153AbVESRAB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 13:00:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519170001.XSCF23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 13:00:01 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505191104410.20274@localhost.localdomain> (Nicolas
 Pitre's message of "Thu, 19 May 2005 11:14:04 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> In fact I think the code in that file might be simplified even further 
NP> eventually, at which point there  might not be much of the original code 
NP> left anymore and the license switched to GPL v2.

I am afraid that kind of code transformation would not change
the copyright issues.

