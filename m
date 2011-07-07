From: bryceadamprescott <bryceadamprescott@gmail.com>
Subject: Strange characters
Date: Thu, 7 Jul 2011 12:15:31 -0700 (PDT)
Message-ID: <1310066131287-6559596.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 21:15:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeu2y-00083G-Im
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 21:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab1GGTPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 15:15:33 -0400
Received: from sam.nabble.com ([216.139.236.26]:34152 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab1GGTPc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 15:15:32 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bryceadamprescott@gmail.com>)
	id 1Qeu2t-0005Kb-9Y
	for git@vger.kernel.org; Thu, 07 Jul 2011 12:15:31 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176772>

I've used subversion before but I've only used git a handful of times. At my
new job I am using git and me and my boss (who is also new to git) is having
a problem with UTF-8 characters. It seems that git is replacing some
characters here and there with strange UTF-8 characters that display as a
question mark in a diamond. Strangely enough the code still compiles with
thousands of warnings about the UTF-8 characters. Any help would be
appreciated.

--
View this message in context: http://git.661346.n2.nabble.com/Strange-characters-tp6559596p6559596.html
Sent from the git mailing list archive at Nabble.com.
