From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-cvsimport "you may need to merge manually"
Date: Fri, 17 Mar 2006 00:08:20 -0800
Message-ID: <7vfylh1ojv.fsf@assigned-by-dhcp.cox.net>
References: <86veud23v0.fsf@blue.stonehenge.com>
	<7vu09x7puo.fsf@assigned-by-dhcp.cox.net>
	<86r75122yj.fsf@blue.stonehenge.com>
	<7vk6at7o06.fsf@assigned-by-dhcp.cox.net>
	<86fylh20x6.fsf@blue.stonehenge.com>
	<20060317072602.GH14562@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 17 09:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKA0X-0005Qx-Nq
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 09:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbWCQIIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 03:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbWCQIIW
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 03:08:22 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16367 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1752554AbWCQIIW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 03:08:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060317080444.YQX17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 17 Mar 2006 03:04:44 -0500
To: smurf@smurf.noris.de
In-Reply-To: <20060317072602.GH14562@smurf.noris.de> (smurf@smurf.noris.de's
	message of "Fri, 17 Mar 2006 08:26:02 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17664>

smurf@smurf.noris.de writes:

> The real workaround is not to import into live branches,
> which is not a git-cvs-specific problem, so I didn't add that
> to its manpage.

Yes.  I sufferred the same problem when I did git-fetch/git-pull,
and there is a clever/ugly workaround for that.
