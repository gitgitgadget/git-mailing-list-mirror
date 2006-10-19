From: Nathaniel Smith <njs@pobox.com>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 19:01:50 +0000 (UTC)
Message-ID: <loom.20061019T205327-196@post.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <200610170155.10536.jnareb@gmail.com> <Pine.LNX.4.64.0610161704240.3962@g5.osdl.org> <45345CBE.8020209@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 19 22:40:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaegX-0005ut-JJ
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 22:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946408AbWJSUkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 16:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946475AbWJSUkJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 16:40:09 -0400
Received: from main.gmane.org ([80.91.229.2]:33225 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1946408AbWJSUkH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 16:40:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GaegM-0005tH-Lf
	for git@vger.kernel.org; Thu, 19 Oct 2006 22:40:03 +0200
Received: from adsl-66-159-194-130.dslextreme.com ([66.159.194.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 22:40:02 +0200
Received: from njs by adsl-66-159-194-130.dslextreme.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 22:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.159.194.130 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060406 Firefox/1.5.0.4 (Debian-1.5.dfsg+1.5.0.4-1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29381>

Aaron Bentley <aaron.bentley <at> utoronto.ca> writes:
> Bazaar also supports multiple unrelated branches in a repository, as
> does CVS, SVN (depending how you squint), Arch, and probably Monotone.

It's quite common in Monotone.  You could probably do it in Mercurial as well,
though I don't know that anyone does.  SVK definitely does it (since each user
has a single repo that's shared by all the projects they work on).

Trivia-ly yours,
-- Nathaniel
