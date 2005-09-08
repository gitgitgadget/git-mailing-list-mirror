From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add git-version-script.
Date: Wed, 07 Sep 2005 18:11:49 -0700
Message-ID: <7v1x402wiy.fsf@assigned-by-dhcp.cox.net>
References: <11259325781492-git-send-email-matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 03:14:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDAxo-0002Oi-UH
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 03:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVIHBLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 21:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVIHBLw
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 21:11:52 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59634 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932558AbVIHBLv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 21:11:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908011150.QGRQ24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Sep 2005 21:11:50 -0400
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <11259325781492-git-send-email-matlads@dsmagic.com> (Martin
	Atukunda's message of "Mon, 5 Sep 2005 18:02:58 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8185>

Martin Atukunda <matlads@dsmagic.com> writes:

> This script simply reports the version of git you have installed.

I wanted to ahve some way of recording the git version, but I am
wondering if 'git' without parameter telling the version number
would be good enough without introducing yet another script.
