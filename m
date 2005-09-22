From: Junio C Hamano <junkio@cox.net>
Subject: Re: uncommon shell code
Date: Thu, 22 Sep 2005 15:03:59 -0700
Message-ID: <7vu0gclpyo.fsf@assigned-by-dhcp.cox.net>
References: <72499e3b05092207326abadd91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:05:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIZAr-0004IJ-4J
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 00:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVIVWEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVIVWEH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 18:04:07 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5542 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751207AbVIVWEF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 18:04:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050922220400.LOKT1974.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Sep 2005 18:04:00 -0400
To: Robert Watson <robert.oo.watson@gmail.com>
In-Reply-To: <72499e3b05092207326abadd91@mail.gmail.com> (Robert Watson's
	message of "Thu, 22 Sep 2005 15:32:43 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9148>

Robert Watson <robert.oo.watson@gmail.com> writes:

> I found the following shell code in git-tag.sh (and others):

My fault; see point 2. in this article:

	http://marc.theaimsgroup.com/?l=git&m=112386506308820&w=2

Please either get used to it or wait until I decide to modernize
the scripts wholesale, whichever comes first.
