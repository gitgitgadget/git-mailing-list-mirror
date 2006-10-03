From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and time
Date: Tue, 03 Oct 2006 02:01:23 +0200
Organization: At home
Message-ID: <efs97p$jnd$1@sea.gmane.org>
References: <20060927002745.15344.qmail@web51005.mail.yahoo.com> <Pine.LNX.4.64.0609261849430.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 03 02:01:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUXjD-0004l7-RN
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 02:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965533AbWJCAB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 20:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965535AbWJCAB2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 20:01:28 -0400
Received: from main.gmane.org ([80.91.229.2]:44181 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965533AbWJCAB2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Oct 2006 20:01:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUXil-0004fI-SN
	for git@vger.kernel.org; Tue, 03 Oct 2006 02:01:16 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 02:01:15 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 02:01:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28240>

Linus Torvalds wrote:

> Now, in some sense, you can ignore the difference between the two models, 
> since you'd think that they are totally equivalent: from the git model, 
> you can always get the "changeset" by just diffing the current state with 
> the previous state, and conversely from the "changeset" model you can 
> always get the "current state" by just applying the changeset to the 
> previous state.

And if I understand correctly, that is how StGit and pg (Patchy Git), which
are patch management applications similar in the purpose to the Quilt, and
are based on Git, works.

http://wiki.procode.org/cgi-bin/wiki.cgi/StGITtheory
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
