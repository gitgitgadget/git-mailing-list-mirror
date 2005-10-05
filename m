From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] hold_index_file_for_update should not unlink failed to open .lock files atexit
Date: Wed, 05 Oct 2005 11:49:51 -0700
Message-ID: <7v3bnfvlww.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0510050758v26b88f4o5f15e3ff01e9cd87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 20:51:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENEKz-0000VR-Fa
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 20:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVJESty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 14:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbVJESty
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 14:49:54 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:8437 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030323AbVJEStx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 14:49:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005184947.MVSC4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 14:49:47 -0400
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9725>

Thanks.  Will apply.
