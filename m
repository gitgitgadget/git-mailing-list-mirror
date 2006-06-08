From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport: complete the cvsps run before starting the import - BAD
Date: Wed, 07 Jun 2006 18:16:28 -0700
Message-ID: <7vk67se9ar.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90606071706w46567f6j4f4addae5c877537@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 03:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo98V-0001e5-4W
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 03:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWFHBQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 21:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWFHBQ3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 21:16:29 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:7661 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932474AbWFHBQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 21:16:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060608011629.RPW12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Jun 2006 21:16:29 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606071706w46567f6j4f4addae5c877537@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 8 Jun 2006 12:06:23 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21465>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> As far as I can see, you had the good sense of not applying this one.
> It is bad, and should be dropped.

Actually it wasn't sense but distraction.  I got sidetracked
while looking at the patch.
