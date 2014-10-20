From: Joseph Nahmias <joe@nahmias.net>
Subject: please document --cached option to git-difftool
Date: Mon, 20 Oct 2014 21:24:15 +0000
Message-ID: <20141020212415.GA532@nahmias.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 23:32:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgKZ4-00055N-8u
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 23:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbaJTVc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 17:32:26 -0400
Received: from skippy.nahmias.net ([162.243.209.86]:47558 "EHLO
	skippy.nahmias.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbaJTVcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 17:32:25 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Oct 2014 17:32:25 EDT
Received: by skippy.nahmias.net (Postfix, from userid 1000)
	id 85971C5793; Mon, 20 Oct 2014 21:24:15 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It would be great if the documentation showed that the git-difftool(1)
command accepted the --cached option.  You can probably steal appropriate
verbiage from the git-diff(1) manpage.

$ git --version
git version 2.1.1

Thanks,
--Joe
