From: Bradly Feeley <bradlyf@gmail.com>
Subject: Inconsistency with -a vs -A
Date: Mon, 18 Apr 2011 03:20:55 +0000 (UTC)
Message-ID: <loom.20110418T051443-551@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 05:25:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBf5O-0001Lf-2R
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 05:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1DRDZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 23:25:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:50846 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240Ab1DRDZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 23:25:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QBf5F-0001HN-JZ
	for git@vger.kernel.org; Mon, 18 Apr 2011 05:25:05 +0200
Received: from ip174-68-93-3.sd.sd.cox.net ([174.68.93.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 05:25:05 +0200
Received: from bradlyf by ip174-68-93-3.sd.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 05:25:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 174.68.93.3 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0) Gecko/20100101 Firefox/4.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171734>

I was curious if there was a reason that some command use -a and some command
use -A. For example, to view all branches the lowercase switch 'a' is used, but
when staging all files with add an uppercase 'A'. Of course I always pick the
wrong one when running either command. Is there a reason for the inconsistency?
Do you think they should be made the same?

Thanks!
Bradly Feeley
