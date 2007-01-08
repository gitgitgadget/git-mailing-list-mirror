From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use xread where we are not checking for EAGAIN/EINTR
Date: Mon, 08 Jan 2007 12:13:26 -0800
Message-ID: <7vk5zxwa3d.fsf@assigned-by-dhcp.cox.net>
References: <1cb8699724ff000fbf0c14ba3e15031e@pinky>
	<7vvejlg1pg.fsf@assigned-by-dhcp.cox.net>
	<459E4270.9090307@shadowen.org> <45A2699F.5060100@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 21:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H40s9-0003Z7-5K
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 21:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbXAHUN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 15:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbXAHUN2
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 15:13:28 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:38512 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422730AbXAHUN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 15:13:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108201326.ZOTL2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 15:13:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8kCc1W00Y1kojtg0000000; Mon, 08 Jan 2007 15:12:37 -0500
To: Andy Whitcroft <apw@shadowen.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36276>

Thanks.  Will queue in 'next' to cook for a few days with the
intent to have it in v1.5.0-rc1.
