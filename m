From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach rev-list an option to read revs from the standard input.
Date: Wed, 06 Sep 2006 17:44:30 -0700
Message-ID: <7vhczk5wup.fsf@assigned-by-dhcp.cox.net>
References: <7v64g1a9f7.fsf@assigned-by-dhcp.cox.net>
	<44FEBFD6.10709@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:44:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL80I-00027r-EK
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWIGAoX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWIGAoW
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:44:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:27353 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161034AbWIGAoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 20:44:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907004420.QPLT6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 20:44:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KCkM1V00p1kojtg0000000
	Wed, 06 Sep 2006 20:44:21 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <44FEBFD6.10709@shadowen.org> (Andy Whitcroft's message of "Wed,
	06 Sep 2006 13:32:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26580>

Andy Whitcroft <apw@shadowen.org> writes:

> Ok, I've tested this with an updated version of my patch to make
> send-pack use this (which I'll send out following this message) and it
> seems to work pretty well.

Eh, I have your earlier one placed on "pu" already.  I do not
mind replacing it with the new one but (1) have you checked what
is in "pu"?  (2) how different is this new one compared to it?
