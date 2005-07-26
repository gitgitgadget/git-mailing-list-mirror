From: Junio C Hamano <junkio@cox.net>
Subject: Updating diff-raw status letter to 'A' for added files.
Date: Mon, 25 Jul 2005 17:18:16 -0700
Message-ID: <7vpst6fmif.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722204120.GD11916@pasky.ji.cz>
	<7vr7dqpmm4.fsf@assigned-by-dhcp.cox.net>
	<20050722212725.GJ11916@pasky.ji.cz>
	<7v8xzyh1ak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 02:18:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxD9Q-00075r-SL
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 02:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVGZASV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 20:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVGZASV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 20:18:21 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:44247 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261535AbVGZAST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 20:18:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050726001810.DUX550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 20:18:10 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Petr Baudis <pasky@suse.cz>
In-Reply-To: <7v8xzyh1ak.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri, 22 Jul 2005 16:24:35 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Since both of you seem to be in favor of using 'A' instead of
'N' for added files in the diff-raw output, here are two patches
requesting for test.

  [PATCH] Use symbolic constants for diff-raw status indicators.
  [PATCH] diff-raw: Use 'A' instead of 'N' for added files.
