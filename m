From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] adding merge-node to parent lines in a commit
Date: Sun, 15 May 2005 14:30:49 -0700
Message-ID: <7vfywoqira.fsf@assigned-by-dhcp.cox.net>
References: <1282.10.10.10.24.1116192147.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 23:31:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXQhG-0001Nn-GW
	for gcvg-git@gmane.org; Sun, 15 May 2005 23:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVEOVax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 17:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVEOVax
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 17:30:53 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24475 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261258AbVEOVav (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 17:30:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515213049.EQHU8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 17:30:49 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <1282.10.10.10.24.1116192147.squirrel@linux1> (seanlkml@sympatico.ca's
 message of "Sun, 15 May 2005 17:22:27 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It is not clear to me ID of what object is being recorded as
SHA1-MERGE-NODE in your proposal.  Care to illustrate?


