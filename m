From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-repack-script: Add option to repack all objects.
Date: Mon, 29 Aug 2005 11:44:35 -0700
Message-ID: <7v3bosbn1o.fsf@assigned-by-dhcp.cox.net>
References: <43102727.2050206@tuxrocks.com>
	<7vbr3hlqjs.fsf@assigned-by-dhcp.cox.net>
	<4312BC27.9010604@tuxrocks.com>
	<7vvf1obsfc.fsf@assigned-by-dhcp.cox.net>
	<7vll2kbqa4.fsf_-_@assigned-by-dhcp.cox.net>
	<43135414.6080400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 20:46:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9odE-0002Pu-Jh
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 20:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVH2Soi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 14:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVH2Soi
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 14:44:38 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44511 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751294AbVH2Soh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 14:44:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050829184437.BPEB7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 Aug 2005 14:44:37 -0400
To: gitzilla@gmail.com
In-Reply-To: <43135414.6080400@gmail.com> (A. Large Angry's message of "Mon,
	29 Aug 2005 14:29:40 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7918>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Frank,
>
> Can you produce a patch to update the git-repack-script documentation to 
> reflect the new functionality?

Not including the doc changes in the patch was my fault, but the
message was meant primarily as an explanation of what I meant,
not for immediate inclusion in the master branch.

I have some other documentation updates sitting in the proposed
updates, so I'd do it myself along with other manual pages if
you and Frank do not mind.

In any case, I first would like to make sure that the proposed
patch you are replying to is something Frank agrees to.
