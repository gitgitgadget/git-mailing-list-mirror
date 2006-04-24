From: Junio C Hamano <junkio@cox.net>
Subject: Re: weird pull behavior as of late
Date: Sun, 23 Apr 2006 18:18:58 -0700
Message-ID: <7vy7xvdb3x.fsf@assigned-by-dhcp.cox.net>
References: <20060423.175953.52710961.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 03:19:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXpjE-0005r9-Vk
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 03:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWDXBTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 21:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWDXBTA
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 21:19:00 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60811 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751472AbWDXBTA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 21:19:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424011859.YFJN17757.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Apr 2006 21:18:59 -0400
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060423.175953.52710961.davem@davemloft.net> (David S. Miller's
	message of "Sun, 23 Apr 2006 17:59:53 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19079>

"David S. Miller" <davem@davemloft.net> writes:

> Updating from f4ffaa452e71495a06376f12f772342bc57051fc to 6b426e785cb81e53dc2fc4dcf997661472b470ef
> Fast forward
>  MAINTAINERS |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> I got 446 objects and this amounted to just a 4 line change to the
> MAINTAINERS file? :-)

That is weird, certainly, and does not match what I am getting...

Updating from f4ffaa452e71495a06376f12f772342bc57051fc to 6b426e785cb81e53dc2fc4dcf997661472b470ef
Fast forward
 MAINTAINERS                                 |    4
 arch/parisc/Kconfig                         |   31 +
 arch/parisc/defconfig                       |  494 +++++++++++------
 ... (many lines later)
 sound/ppc/tumbler.c                         |    2
 91 files changed, 3008 insertions(+), 1286 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_tis.c
