From: Junio C Hamano <junkio@cox.net>
Subject: Re: git binary directory?
Date: Sat, 05 Nov 2005 21:36:59 -0800
Message-ID: <7v4q6q5ock.fsf@assigned-by-dhcp.cox.net>
References: <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net>
	<200511060312.jA63CUcv010887@inti.inf.utfsm.cl>
	<20051106050049.GA5910@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 06:38:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYdDN-0001Ur-DZ
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 06:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVKFFhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 00:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVKFFhE
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 00:37:04 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13055 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750718AbVKFFhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 00:37:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106053701.OWEY9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 00:37:01 -0500
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20051106050049.GA5910@vrfy.org> (Kay Sievers's message of "Sun,
	6 Nov 2005 06:00:49 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11193>

Kay Sievers <kay.sievers@vrfy.org> writes:

> Note that "libexec" is not LSB conform - whatever that means, but it
> should probably not be used for new projects. It states: "Applications
> may use a single subdirectory under /usr/lib."

I had an impression that there are still UNIXy systems that are
not even Linux; do they follow LSB and drop libexec?
