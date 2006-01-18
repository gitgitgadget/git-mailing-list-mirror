From: Junio C Hamano <junkio@cox.net>
Subject: Re: "tla missing -s" equivalent with git/cogito
Date: Wed, 18 Jan 2006 09:46:33 -0800
Message-ID: <7vlkxdwhs6.fsf@assigned-by-dhcp.cox.net>
References: <43CE5666.90502@itaapy.com> <43CE75F0.4060009@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:47:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzHOW-00024h-Qn
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWARRqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 12:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWARRqg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:46:36 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51165 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932393AbWARRqg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 12:46:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118174424.HCPX26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 12:44:24 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43CE75F0.4060009@op5.se> (Andreas Ericsson's message of "Wed, 18
	Jan 2006 18:08:00 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14845>

Andreas Ericsson <ae@op5.se> writes:

> The "pull" above will do the merging nessecary. You can merge several
> branches at once if you like (known as "doing an octopus" in
> gittish. I imagine that's a star-merge in arch).

Arch star-merge is not an octopus.  They have different "merge
strategy" just like we have more than one.  No, I do not
remember the details of how they do it.
