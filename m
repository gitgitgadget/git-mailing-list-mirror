From: Junio C Hamano <junkio@cox.net>
Subject: Re: Default refspec for branches
Date: Wed, 19 Apr 2006 10:45:16 -0700
Message-ID: <7v3bg9bgsz.fsf@assigned-by-dhcp.cox.net>
References: <625fc13d0604190558tf0e8b69n5f5a830a3131f1d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 19:45:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWGjy-0004yq-Vt
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 19:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWDSRpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 13:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWDSRpT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 13:45:19 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26240 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751017AbWDSRpR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 13:45:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419174517.YDQU18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 13:45:17 -0400
To: "Josh Boyer" <jwboyer@gmail.com>
In-Reply-To: <625fc13d0604190558tf0e8b69n5f5a830a3131f1d4@mail.gmail.com>
	(Josh Boyer's message of "Wed, 19 Apr 2006 07:58:58 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18933>

"Josh Boyer" <jwboyer@gmail.com> writes:

> Is there a way to change the default refspec that git pull uses on a
> per branch basis?

No.

But it is a _very_ reasonable thing people would want to be able
to.  Please look at the last entry in:

        Subject: Recent unresolved issues
        Date: Fri, 14 Apr 2006 02:31:36 -0700
	Message-ID: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
