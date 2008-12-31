From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 4/5] Add "jgit clone" to support cloning off URLs that are JGit specific
Date: Wed, 31 Dec 2008 08:12:14 +0100
Message-ID: <200812310812.15305.robin.rosenberg@dewire.com>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org> <1230055423-9944-4-git-send-email-spearce@spearce.org> <1230055423-9944-5-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 31 08:13:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHvGv-0005iY-Es
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 08:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbYLaHMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 02:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbYLaHMU
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 02:12:20 -0500
Received: from mail.dewire.com ([83.140.172.130]:1879 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbYLaHMT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Dec 2008 02:12:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BC2BD8030A7;
	Wed, 31 Dec 2008 08:12:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zZm8rvzyYa4r; Wed, 31 Dec 2008 08:12:15 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D75B2800784;
	Wed, 31 Dec 2008 08:12:15 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1230055423-9944-5-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104253>

Would it be hard to get the progress look better?

-- robin

EGIT.contrib/jgit clone git://repo.or.cz/libgit2.git LIBGIT2
Initialized empty Git repository in /home/me/SW/LIBGIT2/.git                  
Counting objects:       547                                                   
Compressing objects:    100% (192/192)                                        
ts:                     100% (192/192)                                        
Compressing objects:    100% (192/192)                                        
ng objects:             100% (192/192)                                        
Compressing objects:    100% (192/192)                                        
bjects:                 100% (192/192)                                        
Compressing objects:    100% (192/192)
pressing objects:       100% (192/192)
ts:                     100% (192/192)
Compressing objects:    100% (192/192)
Receiving objects:      100% (547/547)
jects:                  100% (192/192)
Compressing objects:    100% (192/192)
ressing objects:        100% (192/192)
s:                      100% (192/192)
Compressing objects:    100% (192/192)
ssing objects:          100% (192/192)
ts:                     100% (192/192)
Compressing objects:    100% (192/192)
 objects:               100% (192/192)
Compressing objects:    100% (192/192)
essing objects:         100% (192/192)
cts:                    100% (192/192)
Compressing objects:    100% (192/192)
g objects:              100% (192/192)
Compressing objects:    100% (192/192)
ressing objects:        100% (192/192)
Resolving deltas:       100% (358/358)
From git://repo.or.cz/libgit2.git
 * [new branch]      master     -> origin/master
