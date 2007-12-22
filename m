From: David Soria Parra <sn_@gmx.net>
Subject: Re: cvs -> git tools?
Date: Sat, 22 Dec 2007 17:00:10 +0100
Message-ID: <fkjcaa$e3l$1@ger.gmane.org>
References: <476C1D9E.4060700@advancedsl.com.ar> <m3zlw3oged.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 17:28:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J67DK-00086M-My
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 17:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbXLVQ2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 11:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbXLVQ2O
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 11:28:14 -0500
Received: from main.gmane.org ([80.91.229.2]:37406 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXLVQ2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 11:28:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J672q-0004fp-3a
	for git@vger.kernel.org; Sat, 22 Dec 2007 16:17:48 +0000
Received: from p57aedda5.dip.t-dialin.net ([87.174.221.165])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Dec 2007 16:17:48 +0000
Received: from sn_ by p57aedda5.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Dec 2007 16:17:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p57aedda5.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <m3zlw3oged.fsf@roke.D-201>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69142>


> There are many CVS -> git tools: git-cvsimport (uses cvsps), parsecvs
> (accesses ,v files directly), fromcvs (in Ruby), cvs2svn development
> branch. But I think only git-cvsimport allows incremental import.

there is also gc-utils (http://sf.net/projects/gcutils) which wraps
git-cvsimport and git-cvsexportcommit to make commiting back into CVS a
little bit easier.
