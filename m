From: Junio C Hamano <junkio@cox.net>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 13:57:18 -0700
Message-ID: <7vekbswfo1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
	<20050527135124.0d98c33e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, perex@suse.cz,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262592AbVE0U51@vger.kernel.org Fri May 27 22:57:01 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262592AbVE0U51@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dblt2-0006ih-8P
	for glk-linux-kernel@gmane.org; Fri, 27 May 2005 22:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVE0U51 (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Fri, 27 May 2005 16:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVE0U51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:57:27 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1430 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262587AbVE0U5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:57:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527205720.QJVZ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 16:57:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050527135124.0d98c33e.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 27 May 2005 13:51:24 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AM" == Andrew Morton <akpm@osdl.org> writes:

AM> I guess the bug here is the use of From: to identify the primary author,
AM> because transporting the patch via email adds ambiguity.

AM> Maybe we should introduce "^Author:"?

While we are at it, we probably would want "^Author-Date:" as
well.
