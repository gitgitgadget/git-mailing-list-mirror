From: Pete Wyckoff <pw@padd.com>
Subject: git-p4 maintainership change
Date: Fri, 23 Jan 2015 13:48:49 -0800
Message-ID: <20150123214849.GA3866@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:49:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEm63-000839-3v
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 22:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbbAWVsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 16:48:52 -0500
Received: from honk.padd.com ([71.19.245.7]:40286 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbbAWVsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 16:48:50 -0500
Received: by honk.padd.com (Postfix, from userid 7770)
	id 0ABBB6371; Fri, 23 Jan 2015 13:48:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262965>

Hi Junio. I'm fortunate enough to need no longer any git
integration with Perforce (p4). I work only in git these days.
Thus you might expect my interest in improving git-p4 would
be waning.

Luke, on the other hand, continues to need git-p4 and is
active in improving it. I think you should consider accepting
patches in that area from him directly. He's contributed many
patches over the years and has helped users to debug their issues
too.

I'll certainly be available to comment on any dodgy code in there
already, and can help with archeological, but will not likely do
any substantive work to git-p4 in the near future.

Luke: I think you have a couple patches outstanding; hope these
can get merged to mainline soon.

Thanks,

		--  Pete
