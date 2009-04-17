From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH 1/1] hook/update: example of how to prevent branch creation
Date: Fri, 17 Apr 2009 01:48:34 +0000 (UTC)
Message-ID: <loom.20090417T014456-100@post.gmane.org>
References: <1239912044-29923-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 03:50:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LudDg-0003BP-4E
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 03:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbZDQBss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 21:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbZDQBsr
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 21:48:47 -0400
Received: from main.gmane.org ([80.91.229.2]:41888 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616AbZDQBsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 21:48:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LudC8-0001jQ-KC
	for git@vger.kernel.org; Fri, 17 Apr 2009 01:48:45 +0000
Received: from adsl-66-123-192-78.dsl.snfc21.pacbell.net ([66.123.192.78])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 01:48:44 +0000
Received: from raible by adsl-66-123-192-78.dsl.snfc21.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 01:48:44 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.123.192.78 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.53 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116724>

Pierre Habouzit <madcoder <at> debian.org> writes:

+# hooks.denycreatebranch
+#   This boolean sets wether remotely creating branches will be denied

s/wether/whether/
