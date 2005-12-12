From: Junio C Hamano <junkio@cox.net>
Subject: Re: diff-core segfault
Date: Mon, 12 Dec 2005 10:50:01 -0800
Message-ID: <7vmzj6i206.fsf@assigned-by-dhcp.cox.net>
References: <1134404990.5928.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 19:52:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElskV-0004J9-DS
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 19:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVLLSuD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 13:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVLLSuD
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 13:50:03 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33006 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932122AbVLLSuC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 13:50:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051212184824.ZHCV17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 13:48:24 -0500
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1134404990.5928.4.camel@localhost.localdomain> (Darrin
	Thompson's message of "Mon, 12 Dec 2005 11:29:50 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13533>

Darrin Thompson <darrint@progeny.com> writes:

> Could someone confirm that this exists on more recent git heads and fix
> if needed?

(1) Yup.  I can reproduce it.
(2) Will look into it when able.
