From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Wed, 28 Sep 2005 22:11:20 -0700
Message-ID: <7vk6h0o3uv.fsf@assigned-by-dhcp.cox.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
	<7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
	<87psqwzs3x.fsf@ualberta.net>
	<7v7jd4n22i.fsf@assigned-by-dhcp.cox.net>
	<20050926191037.GD26340@pasky.or.cz>
	<7vll1jh8zr.fsf@assigned-by-dhcp.cox.net>
	<20050927101744.GD30889@pasky.or.cz>
	<pan.2005.09.29.04.40.14.655977@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 29 07:12:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKqhd-0000fE-Iy
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 07:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVI2FLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 01:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVI2FLY
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 01:11:24 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:16829 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751206AbVI2FLX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 01:11:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929051121.TXYJ9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 01:11:21 -0400
To: git@vger.kernel.org
In-Reply-To: <pan.2005.09.29.04.40.14.655977@smurf.noris.de> (Matthias
	Urlichs's message of "Thu, 29 Sep 2005 06:40:14 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9463>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> I tend to agree -- intentional octopus merges are rare enough.
> For most people, anyway. ;-)

I agree, *and* I think what I proposed is consistent with that.
Essentially, you cannot create an Octopus without asking from
the command line, period.
