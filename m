From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: git daemon on different port
Date: Wed, 4 Feb 2009 11:20:50 +0000 (UTC)
Message-ID: <loom.20090204T111635-586@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 12:22:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUfpy-00012a-DF
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 12:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbZBDLVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 06:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZBDLVG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 06:21:06 -0500
Received: from main.gmane.org ([80.91.229.2]:60078 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbZBDLVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 06:21:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LUfoU-0005Zp-4P
	for git@vger.kernel.org; Wed, 04 Feb 2009 11:21:02 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 11:21:02 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 11:21:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/528.7 (KHTML, like Gecko) Iron/1.0.155.0 Safari/528.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108333>

Hi all.

git daemon --port=12345....

would set the git daemon to listen on port number 12345, right?

Question: What would be the clone URL then ?

Thanks

Stefan
