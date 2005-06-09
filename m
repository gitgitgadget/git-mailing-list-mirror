From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH 0/6] Bunch of new features for cg-log and cg-diff
Date: Thu, 09 Jun 2005 13:03:45 +0200
Message-ID: <42A82211.9060305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:22:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgLlX-00033t-Cm
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 14:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVFIMII (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 08:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVFIMII
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 08:08:08 -0400
Received: from main.gmane.org ([80.91.229.2]:7356 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262362AbVFIMIF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 08:08:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DgL9Z-0006n9-CI
	for git@vger.kernel.org; Thu, 09 Jun 2005 13:24:53 +0200
Received: from 81-224-201-139-no45.tbcn.telia.com ([81.224.201.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:24:53 +0200
Received: from holmsand by 81-224-201-139-no45.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:24:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81-224-201-139-no45.tbcn.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series adds optget-style option parsing, support for almost all
git-diff-* features, git-apply --stat support, common colorization code, 
better performance for cg-log and some other stuff.

/dan

