From: David Soria Parra <sn_@gmx.net>
Subject: Re: how to use git merge -s subtree?
Date: Sun, 06 Jan 2008 02:20:05 +0100
Message-ID: <flpac6$beg$1@ger.gmane.org>
References: <20080105230004.GY29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 02:20:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBKC7-0006Cs-L4
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 02:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbYAFBUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 20:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755609AbYAFBUV
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 20:20:21 -0500
Received: from main.gmane.org ([80.91.229.2]:35079 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858AbYAFBUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 20:20:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JBKBS-0007b8-On
	for git@vger.kernel.org; Sun, 06 Jan 2008 01:20:15 +0000
Received: from p57aee59d.dip.t-dialin.net ([87.174.229.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Jan 2008 01:20:14 +0000
Received: from sn_ by p57aee59d.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Jan 2008 01:20:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p57aee59d.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080105230004.GY29972@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69697>

As said in IRC, subtree is not made for that as far is a understand.

Quite frankly the given workflow doesnot work for me as subtree imports
the things into some directory that it was not supposed to merge it into
(x/z/ instead of B).

                              dsp
