From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Pickaxe fixes.
Date: Mon, 30 May 2005 00:35:39 -0700
Message-ID: <7vk6lh6u9g.fsf@assigned-by-dhcp.cox.net>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
	<7v7jhjy8uw.fsf@assigned-by-dhcp.cox.net>
	<20050528105914.GA8467@cip.informatik.uni-erlangen.de>
	<7vpsvbuxzb.fsf@assigned-by-dhcp.cox.net>
	<20050528162257.GE4881@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 09:33:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcelz-0003Zr-Rt
	for gcvg-git@gmane.org; Mon, 30 May 2005 09:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVE3Hfp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 03:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVE3Hfp
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 03:35:45 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:3515 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261539AbVE3Hfl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 03:35:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530073541.CGOE1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 03:35:41 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050528162257.GE4881@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Sat, 28 May 2005 18:22:57 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> ... However at the moment I don't
TG> have an opinion on this, I have to use it a bit longer. But it is a good
TG> thing that I know by now that it limits its view to the subdirectory
TG> after your patch-train is applied.

Your opinion on this would not count anymore ;-).  Pathspec is now
at the beginning of the processiong chain.

