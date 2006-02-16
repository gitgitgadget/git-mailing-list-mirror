From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fake linear history in a deterministic manner.
Date: Thu, 16 Feb 2006 15:54:30 -0800
Message-ID: <7v7j7uamh5.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 00:54:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9sxH-0006zv-3u
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 00:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWBPXyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 18:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWBPXyc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 18:54:32 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47055 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750810AbWBPXyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 18:54:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216235323.GGNB3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 18:53:23 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 13 Feb 2006 14:46:38 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16318>

Martin, (and Martyn),

I just cloned the gitcvs via git locally, exported it via
gitcvs, and ran "cvs log" and "cvs annotate README" there.  

Good job.  I really had a good laugh looking at the generated
output.  It just looks like .... CVS! ;-)

I haven't read the code in detail (I tend to start nitpicking
the details without looking at a bigger picture, once I start
reading the code, so I try to only give superficial look until I
know I'll have tons of time to spend on it).

But it looks like a fun project.
