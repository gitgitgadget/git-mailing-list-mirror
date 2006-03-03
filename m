From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] annotate should number lines starting with 1
Date: Thu, 02 Mar 2006 23:09:27 -0800
Message-ID: <7vfym02ee0.fsf@assigned-by-dhcp.cox.net>
References: <200603022327.k22NRVek023304@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 03 08:09:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF4Pz-00050K-Ou
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 08:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbWCCHJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 02:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbWCCHJ3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 02:09:29 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13459 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752070AbWCCHJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 02:09:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060303070934.BOEK25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Mar 2006 02:09:34 -0500
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <200603022327.k22NRVek023304@agluck-lia64.sc.intel.com> (Tony
	Luck's message of "Thu, 2 Mar 2006 15:27:31 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17137>

"Luck, Tony" <tony.luck@intel.com> writes:

> C programmers are well used to counting from zero, but every
> other text file tool starts counting from 1.

Thanks.

I agree with this patch 100%, so I am going to take this patch.

But git-cvsserver might need some adjustments.
Martin?
