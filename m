From: milindkanchan <milindkanchan@gmail.com>
Subject: Reverting a specific commit
Date: Thu, 23 Sep 2010 00:13:43 -0700 (PDT)
Message-ID: <1285226023268-5561992.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 09:13:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyg05-0002zu-Sj
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 09:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab0IWHNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 03:13:44 -0400
Received: from kuber.nabble.com ([216.139.236.158]:57853 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab0IWHNo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 03:13:44 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <milindkanchan@gmail.com>)
	id 1Oyfzz-0007zf-8q
	for git@vger.kernel.org; Thu, 23 Sep 2010 00:13:43 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156854>


Hi All,

I am using git for code management.

I have some query regarding reverting the commit in git.

Can we revert a specific commit in git ?

Eg. One of our X developer has committed the code in master branch last
week, after which there were several commits to master branch, now there was
an issue with the code committed by X developer and now I need to
revert/discard just his commit keeping the other commits done after him as
intact.

Can anybody give a solution for this with all the commands.

Thanks & Regard
M.K

-- 
View this message in context: http://git.661346.n2.nabble.com/Reverting-a-specific-commit-tp5561992p5561992.html
Sent from the git mailing list archive at Nabble.com.
