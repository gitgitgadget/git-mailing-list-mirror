From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use "-script" postfix for scripts
Date: Sat, 13 Aug 2005 01:57:22 -0700
Message-ID: <7v64uaqknh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508121526050.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vwtmrxjbb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508121451590.3295@g5.osdl.org>
	<20050812222716.GD22778@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 10:58:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3rpb-00049K-Er
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 10:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVHMI5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 04:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVHMI5Z
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 04:57:25 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:31141 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932136AbVHMI5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 04:57:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813085724.CAIG19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 04:57:24 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050812222716.GD22778@mythryan2.michonline.com> (Ryan
	Anderson's message of "Fri, 12 Aug 2005 18:27:16 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> See, for example, the history on git-rename-script for why this is good.

Why do you think it is a good example?  What happens when next
time somebody rewrites it in C?
