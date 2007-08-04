From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix handling of $file_name in feed generation
Date: Fri, 03 Aug 2007 17:25:51 -0700
Message-ID: <7v7iockuwg.fsf@assigned-by-dhcp.cox.net>
References: <20070803020555.GB8593@dervierte>
	<200708031110.55969.jnareb@gmail.com>
	<200708031950.43126.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	Robert Fitzsimons <robfitz@273k.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 02:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH7Su-0004of-3h
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 02:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763713AbXHDAZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 20:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762894AbXHDAZx
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 20:25:53 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52708 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762282AbXHDAZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 20:25:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804002552.GLKI7193.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 3 Aug 2007 20:25:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XcRr1X0041kojtg0000000; Fri, 03 Aug 2007 20:25:51 -0400
In-Reply-To: <200708031950.43126.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 3 Aug 2007 19:50:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54776>

Thanks.  This came in while I already tagged -rc4 and was doing
the final round of tests and packaging, so has to become the
first thing post -rc4, unfortunately.

The format of the e-mail message you sent out could use much
improvements but I'll let it pass this time.
