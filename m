From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add a diff-files command (revised and cleaned up)
Date: Thu, 28 Apr 2005 14:04:47 -0700
Message-ID: <7vis267guo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0504272239420.14033@localhost.localdomain>
	<Pine.LNX.4.58.0504280950340.18901@ppc970.osdl.org>
	<Pine.LNX.4.62.0504281327520.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 23:01:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRG6l-0001FD-9a
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 22:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVD1VE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVD1VE6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:04:58 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64466 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262277AbVD1VEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:04:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428210449.IBVO7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 17:04:49 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0504281327520.14033@localhost.localdomain> (Nicolas
 Pitre's message of "Thu, 28 Apr 2005 13:35:23 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> What about this patch then?
NP> =====
NP> Give show-files the ability to process exclusion pattern.

I just tried this, and I like it.  Thanks!

