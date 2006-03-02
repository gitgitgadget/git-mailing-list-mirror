From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-annotate dies when a patch is missing trailing newline
Date: Wed, 01 Mar 2006 19:37:51 -0800
Message-ID: <7voe0pcy9c.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90603011653l7956d5dat99d88a7da98d21b6@mail.gmail.com>
	<7vslq1d1pr.fsf@assigned-by-dhcp.cox.net>
	<46a038f90603011907h6d0d4450w426afb9ada33ddb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 04:38:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEedZ-00066Y-OF
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 04:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWCBDhy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 22:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWCBDhx
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 22:37:53 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64696 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932231AbWCBDhx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 22:37:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060302033416.FTAC17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 22:34:16 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90603011907h6d0d4450w426afb9ada33ddb0@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 2 Mar 2006 16:07:00 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17043>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Yes, excellent! BTW, I just realized that git-cvsserver is in master,
> but the "git-annotate -S" patch isn't there, so cvs annotate dies. Is
> anything holding the patch back in next?

Is -S in next?
