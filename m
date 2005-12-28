From: Anand Kumria <wildfire@progsoc.org>
Subject: git-inject-tarball
Date: Wed, 28 Dec 2005 13:40:15 +1100
Message-ID: <pan.2005.12.28.02.40.14.577883@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Dec 28 06:21:19 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErTkQ-0006TO-An
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 06:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVL1FU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 00:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVL1FU6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 00:20:58 -0500
Received: from main.gmane.org ([80.91.229.2]:38851 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751141AbVL1FU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2005 00:20:58 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ErTk3-0006OE-6p
	for git@vger.kernel.org; Wed, 28 Dec 2005 06:20:51 +0100
Received: from 203.7.227.183 ([203.7.227.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Dec 2005 06:20:51 +0100
Received: from wildfire by 203.7.227.183 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Dec 2005 06:20:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203.7.227.183
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14095>


Hi,

In the Everyday commands[1], there is an example of of extracting a
tarball and then working with it.  I'm finding that I'm doing this fairly
often -- I was just wondering if anyone had anything like a
'git-inject-tarball' script they'd written up.

Thanks,
Anand

[1]: http://www.kernel.org/pub/software/scm/git/docs/everyday.html
