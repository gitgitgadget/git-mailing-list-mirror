From: Junio C Hamano <junkio@cox.net>
Subject: Re: suggestion: store the URL somewhere in .git/
Date: Mon, 22 Aug 2005 22:16:36 -0700
Message-ID: <7vslx1xmff.fsf@assigned-by-dhcp.cox.net>
References: <430A30C8.3080908@linuxmachines.com>
	<Pine.LNX.4.63.0508222217310.695@wgmdd8.biozentrum.uni-wuerzburg.de>
	<430A7FE6.4010801@linuxmachines.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 07:17:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7R9Q-0007qP-Rl
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 07:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVHWFQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 01:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVHWFQk
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 01:16:40 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:42115 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750825AbVHWFQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 01:16:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823051637.CSQF1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 01:16:37 -0400
To: Jeff Carr <jcarr@linuxmachines.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff Carr <jcarr@linuxmachines.com> writes:

> So my small "feature" request reduces to adding
> something like this to git-pull-script. Thanks, Jeff

Somebody else earlier asked for fetch and pull to default to
"origin" URL, and the necessary change is already in the
proposed updates branch.
