From: Arnauld Van Muysewinkel <arnauldvm+git@gmail.com>
Subject: Git to svn: Adding commit date to log messages
Date: Thu, 10 Jun 2010 12:06:39 +0000 (UTC)
Message-ID: <loom.20100610T140006-684@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 10 14:10:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMgaZ-0007V8-5A
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 14:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759017Ab0FJMKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 08:10:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:38180 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758925Ab0FJMKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 08:10:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OMgaB-0007Lc-Gw
	for git@vger.kernel.org; Thu, 10 Jun 2010 14:10:03 +0200
Received: from 195.206.74.130 ([195.206.74.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 14:10:03 +0200
Received: from arnauldvm+git by 195.206.74.130 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 14:10:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.206.74.130 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.0 (KHTML, like Gecko) Chrome/6.0.408.1 Safari/534.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148861>

How should I do to have the author (or committer) name/date added to the log 
message when "dcommitting" to svn?

For example, if the log message in Git is:
  This is a nice modif

I'd like to have the message in svn be something like:
  This is a nice modif
  -----
  Author: John Doo <John.Doo@company.com>  2010-06-10 12:38:22
  Committer: Nice Guy <nguy@acme.org>  2010-06-10 14:05:42

Any simple way? Hook needed? Other suggestion?

Thank you in advance.


Yours faithfully,

-- 
Arnauld Van Muysewinkel
