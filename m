From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn performance
Date: Sat, 25 Oct 2014 05:32:18 +0000
Message-ID: <20141025053218.GA30872@dcvr.yhbt.net>
References: <1414214603.1212.BPMail_high_carrier@web172304.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 20:31:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi679-0000jm-3j
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 20:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbaJYSaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 14:30:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47515 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbaJYSay (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 14:30:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53EC1FB0B;
	Sat, 25 Oct 2014 05:32:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414214603.1212.BPMail_high_carrier@web172304.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> the old didn't missing a revision - just a revision 'message' - blank
> instead of 3 words, above the git svn id. I supppse it is possible
> some power problem or etc caused this. I'll check the other branches
> as well, and possibly clone again to be sure. ( The new clone did have
> one break...)

Oh, there's a possibility the commit message in SVN was edited/added
after-the-fact, but that depends on the SVN admin (most never allow
or do it).
