From: Ron Garret <ron1@flownet.com>
Subject: Branching a subset of your working tree
Date: Mon, 22 Feb 2010 13:07:04 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-F4D522.13070422022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 22:07:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjfV2-0007BS-2s
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 22:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab0BVVHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 16:07:23 -0500
Received: from lo.gmane.org ([80.91.229.12]:48812 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab0BVVHW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 16:07:22 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NjfUq-000752-L1
	for git@vger.kernel.org; Mon, 22 Feb 2010 22:07:16 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 22:07:16 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 22:07:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140714>

What is the recommended way to create a branch that contains a subset of 
your working tree?  The use case is creating a distribution branch that 
will be pushed out to a server and I only want to include files that are 
ready to be released.

Thanks,
rg
