From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [git-svn] [FEATURE-REQ] track merges from git
Date: Sat, 05 Sep 2009 11:23:54 +0200
Organization: At home
Message-ID: <h7tana$j38$1@ger.gmane.org>
References: <4A9565ED.4010608@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 11:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjrVS-0000MS-NU
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 11:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbZIEJYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 05:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbZIEJYQ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 05:24:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:46909 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbZIEJYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 05:24:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MjrVJ-0000L7-Pm
	for git@vger.kernel.org; Sat, 05 Sep 2009 11:24:17 +0200
Received: from abvd254.neoplus.adsl.tpnet.pl ([83.8.201.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 11:24:17 +0200
Received: from jnareb by abvd254.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 11:24:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvd254.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127808>

Ximin Luo wrote:

> For now I just have a .git/info/grafts, but this doesn't get exported anywhere,
> so if other people "git svn clone" from svn, or "git clone" from my git repo,
> they don't get the merge information.

In future version of git (I'm not sure if it is in master yet) there
would be refs/replace feature (grafts-like), which can be exported.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
