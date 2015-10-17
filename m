From: Jaap Droogers <jaap@boerendroogers.nl>
Subject: dead link on manual page
Date: Sat, 17 Oct 2015 12:33:02 +0200
Message-ID: <562223DE.9080301@boerendroogers.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 17 12:51:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnP5R-0001Hr-Aa
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 12:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbbJQKvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 06:51:37 -0400
Received: from 137.ip-37-187-177.eu ([37.187.177.137]:47792 "EHLO
	peer.boerendroogers.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbbJQKtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 06:49:53 -0400
X-Greylist: delayed 1004 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2015 06:49:52 EDT
Received: from localhost ([127.0.0.1] helo=[IPv6:::1])
	by peer.boerendroogers.nl with esmtp (Exim 4.80)
	(envelope-from <jaap@boerendroogers.nl>)
	id 1ZnOnO-0006yP-Qx
	for git@vger.kernel.org; Sat, 17 Oct 2015 12:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
X-Spam_report: Spam detection software, running on the system "peer.boerendroogers.nl", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi, In the last sentence of page http://www.git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository
    I found a dead link to page http://www.git-scm.com/book/en/v2/1-git-server/_git_on_the_server
    (this dead link also appears on the paragraph "Cloning an Existing Repository",
    half a screen above the end) [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed th 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279786>

Hi,

In the last sentence of page
http://www.git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository I
found a dead link to page
http://www.git-scm.com/book/en/v2/1-git-server/_git_on_the_server
(this dead link also appears on the paragraph "Cloning an Existing
Repository", half a screen above the end)

That should be replaced by:
http://www.git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server
