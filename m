From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH]: git-merge-one-file-script use /usr/bin/env to call
 bash
Date: Sat, 07 May 2005 01:52:55 -0700
Message-ID: <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 07 10:52:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUL1u-00016Q-U2
	for gcvg-git@gmane.org; Sat, 07 May 2005 10:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVEGIyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 04:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVEGIxm
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 04:53:42 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14215 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262865AbVEGIw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 04:52:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050507085256.TKFQ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 May 2005 04:52:56 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050507084549.GF23680@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Sat, 7 May 2005 10:45:49 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A quick question.  Which construct in this bashism?
Not using backtick but saying $(command)?

