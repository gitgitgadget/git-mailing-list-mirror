From: Junio C Hamano <junkio@cox.net>
Subject: Re: Experiences with git-clone-pack and rsync
Date: Thu, 04 Aug 2005 23:39:44 -0700
Message-ID: <7vpsssopjj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508042230150.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 08:44:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0vuF-0002H8-6e
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 08:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVHEGli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 02:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbVHEGlg
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 02:41:36 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27636 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262882AbVHEGjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2005 02:39:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050805063944.WDGF1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 Aug 2005 02:39:44 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But maybe I just cried "wolf"...

I do not think you are crying wolf.  I shared the same concern
from the beginning and that was partly why I was pushing for
the dumb server approach.
