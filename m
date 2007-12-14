From: Jing Xue <jingxue@digizenstudio.com>
Subject: git-send-email doesn't like me+git ML
Date: Thu, 13 Dec 2007 20:47:53 -0500
Message-ID: <20071214014753.GB8914@fawkes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 02:48:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2zf7-0000Wn-Dm
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 02:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761539AbXLNBsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 20:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759027AbXLNBsB
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 20:48:01 -0500
Received: from k2smtpout04-02.prod.mesa1.secureserver.net ([64.202.189.173]:58993
	"HELO k2smtpout04-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758610AbXLNBsB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 20:48:01 -0500
Received: (qmail 12162 invoked from network); 14 Dec 2007 01:48:00 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout04-02.prod.mesa1.secureserver.net (64.202.189.173) with ESMTP; 14 Dec 2007 01:48:00 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 1F7DA100A37
	for <git@vger.kernel.org>; Fri, 14 Dec 2007 01:48:00 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyV1fQM7f+8M for <git@vger.kernel.org>;
	Thu, 13 Dec 2007 20:47:54 -0500 (EST)
Received: from fawkes.hq.digizenstudio.com (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 5D523100099
	for <git@vger.kernel.org>; Thu, 13 Dec 2007 20:47:54 -0500 (EST)
Received: by fawkes.hq.digizenstudio.com (Postfix, from userid 1000)
	id 50C0A9ACFB; Thu, 13 Dec 2007 20:47:53 -0500 (EST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68212>

OK, this is bewildering. I tried a couple of times sending a trivial
patch (the one that makes git-stash show keep quiet when there aren't
any stashes), but it never made it to the list every time I used
git-send-email, yet as soon as I did it as a regular email, i.e.,
starting a new message in mutt, pasting the patch into the body, and
sending it, it worked just fine.

My mail log shows the mails (the one thru git-send-email) went out just
fine.  And it always worked when I tried to use git-send-email to send
the patch to my gmail address. It just doesn't work with the list - and
that obviously can't be. 8-)

-- 
Jing Xue
