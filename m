From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git rm -- recursive directories
Date: Sun, 24 Apr 2005 14:34:52 -0700
Message-ID: <7vmzrnsvsz.fsf@assigned-by-dhcp.cox.net>
References: <200504241709.05689.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 23:30:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPofu-0001hg-Sj
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 23:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVDXVez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 17:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVDXVez
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 17:34:55 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11757 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262441AbVDXVey (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 17:34:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050424213453.ZQWB29099.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 24 Apr 2005 17:34:53 -0400
To: "Joshua T. Corbin" <jcorbin@wunjo.org>
In-Reply-To: <200504241709.05689.jcorbin@wunjo.org> (Joshua T. Corbin's
 message of "Sun, 24 Apr 2005 17:09:05 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Why not also make add non recursive by default and give -r
option when you want recursive?

