From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: git log --graph and root commits
Date: Fri, 13 Feb 2009 04:16:30 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp9t0u.va9.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 05:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXpVE-0003Tp-Bh
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 05:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbZBMEQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 23:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbZBMEQo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 23:16:44 -0500
Received: from main.gmane.org ([80.91.229.2]:48899 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbZBMEQo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 23:16:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LXpTk-0003JB-QO
	for git@vger.kernel.org; Fri, 13 Feb 2009 04:16:40 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 04:16:40 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 04:16:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109704>

I was wondering if there was any way, when using 'git log
--graph --pretty=oneline' to get a different marker (perhaps
an underscore) for a root commit.

I have a couple of repos in which there are multiple roots
(a bit like the git tree itself, which has separately rooted
html and man branches), and it would be nice to see some
sign of that break in the git log graph.

Thanks,

Sitaram
