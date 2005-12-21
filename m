From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GIT: Support [address] in URLs
Date: Wed, 21 Dec 2005 15:03:37 -0800
Message-ID: <7vaceu2gty.fsf@assigned-by-dhcp.cox.net>
References: <20051221.192342.132228413.yoshfuji@linux-ipv6.org>
	<7vr7866uww.fsf@assigned-by-dhcp.cox.net>
	<20051222.072045.31468866.yoshfuji@linux-ipv6.org>
	<7v1x065blx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 00:03:51 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpCzn-0006Sf-OB
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 00:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVLUXDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 18:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVLUXDl
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 18:03:41 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11228 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932308AbVLUXDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 18:03:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221230247.HVQK20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 18:02:47 -0500
To: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13910>

YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org> writes:

> But, we definitely do
>         scp file1 file2 ... '[3ffe:ffff:...:1]:/tmp/'
> like
>         scp file1 file2 ... remote.example.com:/tmp/

Thanks.
