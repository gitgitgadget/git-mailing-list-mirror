From: David Soria <sn_@gmx.net>
Subject: Re: Question about "git commit -a"
Date: Thu, 4 Oct 2007 22:34:11 +0000 (UTC)
Message-ID: <fe3pp3$8p1$1@sea.gmane.org>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:34:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdZHH-00037F-2b
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 00:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760389AbXJDWed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 18:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760396AbXJDWed
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 18:34:33 -0400
Received: from main.gmane.org ([80.91.229.2]:60428 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760357AbXJDWec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 18:34:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IdZGy-00046d-18
	for git@vger.kernel.org; Thu, 04 Oct 2007 22:34:24 +0000
Received: from p54967288.dip.t-dialin.net ([84.150.114.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 22:34:24 +0000
Received: from sn_ by p54967288.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 22:34:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54967288.dip.t-dialin.net
User-Agent: pan 0.120 (Plate of Shrimp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Am Thu, 04 Oct 2007 17:38:25 +0200 schrieb Paolo Ciarrocchi:

> Hi all,
> I was just wondering why git commit doesn't default to "-a" (yes, it's
> another question that came up during a chat with a mercurial user) and
> I didn't find an answer to that.


in fact i do just a git-config alias.commit 'commit -a' in my repository
