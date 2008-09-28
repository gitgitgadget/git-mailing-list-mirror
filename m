From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/8] Docs: send-email: Man page option ordering
Date: Sun, 28 Sep 2008 10:08:09 +0200
Organization: At home
Message-ID: <gbne1a$8g2$1@ger.gmane.org>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 10:09:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjrLY-00051a-1d
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 10:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbYI1IIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbYI1IIV
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 04:08:21 -0400
Received: from main.gmane.org ([80.91.229.2]:43611 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbYI1IIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 04:08:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KjrKD-0003Re-9U
	for git@vger.kernel.org; Sun, 28 Sep 2008 08:08:17 +0000
Received: from abvg103.neoplus.adsl.tpnet.pl ([83.8.204.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 08:08:17 +0000
Received: from jnareb by abvg103.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 08:08:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvg103.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96945>

Michael Witten wrote:

> Now the man page lists the options in alphabetical
> order (in terms of the 'main' part of an option's
> name).

I know it is a matter of taste, but I prefer having options
on man page in functional order, grouped by function, perhaps
with subsections to group them (c.f. git-rev-list man page).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
