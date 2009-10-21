From: Dexter Riley <edbeaty@charter.net>
Subject: drawbacks to svn server + git-svn vs git server?
Date: Wed, 21 Oct 2009 08:05:21 -0700 (PDT)
Message-ID: <25994334.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 17:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ckl-00074s-Vh
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 17:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbZJUPFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 11:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754055AbZJUPFS
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 11:05:18 -0400
Received: from kuber.nabble.com ([216.139.236.158]:36378 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbZJUPFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 11:05:17 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N0ckb-0006Ke-TK
	for git@vger.kernel.org; Wed, 21 Oct 2009 08:05:21 -0700
X-Nabble-From: edbeaty@charter.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130925>


Hello.  My group is currently using subversion on our version control server,
but would like to move to git as a client.  We are considering using
git-svn, to avoid revalidating the server software.  My question is, are
there any major disadvantages to using git-svn versus git?  I know that the
git repository would be smaller.  I'm more concerned about possible svn
repository corruption, performance when pushing large merges back to svn,
and any gotchas you might have encountered.
Any advice would be greatly appreciated.
Thanks,
Ed
-- 
View this message in context: http://www.nabble.com/drawbacks-to-svn-server-%2B-git-svn-vs-git-server--tp25994334p25994334.html
Sent from the git mailing list archive at Nabble.com.
