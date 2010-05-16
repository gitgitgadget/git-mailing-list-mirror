From: git_user101 <m.aqadjanimemar@student.ru.nl>
Subject: Error: Unable to append to logs/HEAD: Permission denied
Date: Sun, 16 May 2010 16:18:32 -0700 (PDT)
Message-ID: <1274051912050-5063068.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 01:18:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODn6W-0003H9-17
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 01:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894Ab0EPXSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 19:18:34 -0400
Received: from kuber.nabble.com ([216.139.236.158]:39984 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab0EPXSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 19:18:33 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <m.aqadjanimemar@student.ru.nl>)
	id 1ODn6O-0002io-1s
	for git@vger.kernel.org; Sun, 16 May 2010 16:18:32 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147201>


Hi,
when I use the command: git push
I get these two errors:
...
error: Unable to append to logs/HEAD: Permission denied
...
error: failed to push some refs to 'ssh://remote server'

However, the changes are pushed in the remote repository.

Does somebody have any ideas?
Thanx,
-- 
View this message in context: http://git.661346.n2.nabble.com/Error-Unable-to-append-to-logs-HEAD-Permission-denied-tp5063068p5063068.html
Sent from the git mailing list archive at Nabble.com.
