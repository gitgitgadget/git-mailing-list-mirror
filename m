From: walt <wa1ter@myrealbox.com>
Subject: cg-update bug?
Date: Thu, 19 Jan 2006 06:07:55 -0800
Organization: none
Message-ID: <dqo6fs$sr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 19 15:12:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzaVJ-0007Yl-1a
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 15:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbWASOLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 09:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbWASOLF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 09:11:05 -0500
Received: from main.gmane.org ([80.91.229.2]:39137 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161208AbWASOLE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 09:11:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EzaTr-00079D-3w
	for git@vger.kernel.org; Thu, 19 Jan 2006 15:09:39 +0100
Received: from adsl-69-234-194-44.dsl.irvnca.pacbell.net ([69.234.194.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jan 2006 15:09:39 +0100
Received: from wa1ter by adsl-69-234-194-44.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jan 2006 15:09:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-194-44.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060118)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14909>

Hi Petr,

After this commit:
commit 476b0a8846f08fed436a393de42d1476c2d97c60
committer Petr Baudis <xpasky@machine.or.cz> Sun, 15 Jan 2006 15:34:55
Make cg-fetch w/o -v be silent about the fetched changes altogether

cg-update is now also silent about fetched changes, but
there is no -v flag for cg-update.  Could it be added
so I can get the old behavior back?

Thanks!
