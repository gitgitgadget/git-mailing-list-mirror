From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
Date: Fri, 23 Jun 2006 19:46:15 -0700
Message-ID: <7vr71f5kzs.fsf@assigned-by-dhcp.cox.net>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:46:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtyAE-0007yx-Tc
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWFXCqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933204AbWFXCqX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:46:23 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53150 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932132AbWFXCqW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 22:46:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624024621.UDDU554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 22:46:21 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz> (Petr Baudis's
	message of "Sat, 24 Jun 2006 04:34:29 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22479>

Just to let you know, I already have v3 in my tree which is
merged in "pu".  With the two fixes I sent you earlier I think
it is in a good shape to be cooked in "next".

I do not think I'd have trouble applying this new series (I
would probably start from "master" to apply it and perhaps merge
or --squash merge it onto pb/gitpm topic branch that has v3 with
the two fixes I sent you separately) but we will see soon
enough.
