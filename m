From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid misleading success message on error
Date: Wed, 21 Dec 2005 12:47:19 -0800
Message-ID: <7vmziu6uug.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512211752340.16125@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Dec 21 21:47:34 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpArx-0005XF-F1
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 21:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVLUUr0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 15:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVLUUr0
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 15:47:26 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:40897 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751163AbVLUUrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 15:47:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221204723.OCHU25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 15:47:23 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512211752340.16125@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 21 Dec 2005 17:53:29 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13896>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When a push fails (for example when the remote head does not fast forward 
> to the desired ref) it is not correct to print "Everything up-to-date".

Thanks.
