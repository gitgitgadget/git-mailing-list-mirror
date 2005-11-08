From: Dave Jones <davej@redhat.com>
Subject: git-rev-tree
Date: Mon, 7 Nov 2005 21:12:32 -0500
Message-ID: <20051108021232.GB10835@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 08 03:14:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZIyf-0007Pu-Ax
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 03:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVKHCMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 21:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVKHCMo
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 21:12:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030219AbVKHCMm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 21:12:42 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id jA82CXL3016100
	for <git@vger.kernel.org>; Mon, 7 Nov 2005 21:12:33 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id jA82CXV08865
	for <git@vger.kernel.org>; Mon, 7 Nov 2005 21:12:33 -0500
Received: from nwo.kernelslacker.org (vpn83-122.boston.redhat.com [172.16.83.122])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id jA82CXRW014014
	for <git@vger.kernel.org>; Mon, 7 Nov 2005 21:12:33 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id jA82CWQt021112
	for <git@vger.kernel.org>; Mon, 7 Nov 2005 21:12:32 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id jA82CWGr021111
	for git@vger.kernel.org; Mon, 7 Nov 2005 21:12:32 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11302>

Can someone remind me what the deprecated git-rev-tree command did,
or how this should be fixed up to use newer git commands?

I'm trying to get git-changes-script working, but all the
variants I've found on the web use this deprecated tool.

Any clues ?

		Dave
