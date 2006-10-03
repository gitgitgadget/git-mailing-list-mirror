From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add snapshot to log; remove redundant commit from log
Date: Tue, 03 Oct 2006 11:12:10 +0200
Organization: At home
Message-ID: <eft9ge$un0$5@sea.gmane.org>
References: <20060928235050.63085.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 03 11:15:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUgNF-0007uc-QD
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 11:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWJCJP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 05:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWJCJP1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 05:15:27 -0400
Received: from main.gmane.org ([80.91.229.2]:31691 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030268AbWJCJP0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 05:15:26 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GUgMf-0007nP-Q3
	for git@vger.kernel.org; Tue, 03 Oct 2006 11:15:02 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 11:15:01 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 11:15:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28258>

Luben Tuikov wrote:

> This removes redundant "commit" from log in favor of adding
> "snapshot".

"Snapshot" link should be added gitweb_have_snapshot conditionally.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
