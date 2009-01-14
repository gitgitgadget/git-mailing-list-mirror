From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [announce] gc
Date: Wed, 14 Jan 2009 02:31:18 +0100
Organization: At home
Message-ID: <gkjf93$r5e$1@ger.gmane.org>
References: <20081222212407.47c9ab1e.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 02:33:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMud8-00071c-RP
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 02:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbZANBb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 20:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757112AbZANBb0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 20:31:26 -0500
Received: from main.gmane.org ([80.91.229.2]:48466 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759836AbZANBbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 20:31:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMubL-0000GO-R3
	for git@vger.kernel.org; Wed, 14 Jan 2009 01:31:23 +0000
Received: from abvd199.neoplus.adsl.tpnet.pl ([83.8.201.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 01:31:23 +0000
Received: from jnareb by abvd199.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 01:31:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvd199.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105570>

Stephen Haberman wrote:

> This is just a small collections of hooks, scripts, and practices I
> developed while working on a not-distributed/corporate project.
> 
> A quick list is: svn-like revision numbers (via tagging every commit)
> (don't flame me, please), combined diff-enabled commit emails*, Hudson
> hooks, trac hooks, branch locking, same-repo-separate-DAG git
> server-side config storage and export-on-push, and developer-side
> push/pull scripts that "just work".
> 
> http://github.com/stephenh/gc
> 
> Hopefully others find it as useful.

Added to http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
