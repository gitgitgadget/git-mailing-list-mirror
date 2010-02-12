From: Ron Garret <ron1@flownet.com>
Subject: Individual file snapshots
Date: Fri, 12 Feb 2010 04:03:05 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-CD3223.04030512022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 13:04:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfuFl-0004Uq-3D
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 13:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756855Ab0BLMDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 07:03:33 -0500
Received: from lo.gmane.org ([80.91.229.12]:36823 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756192Ab0BLMD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 07:03:28 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NfuF4-0003oA-Jl
	for git@vger.kernel.org; Fri, 12 Feb 2010 13:03:26 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 13:03:26 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 13:03:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139691>

Before I reinvent the wheel...

I would like to be able to store snapshots of individual files without 
making a commit on the main branch.  The scenario is that I've written 
some experimental code that I have decided not to keep as part of the 
main project, but which I might want to refer back to some day.  Is 
there any easy way of doing that in git?

Thanks,
rg
