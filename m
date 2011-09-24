From: tactical <a5158017@nepwk.com>
Subject: Re: More Beginning Git Questions
Date: Sat, 24 Sep 2011 21:22:31 +0100
Message-ID: <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
References: <4E7C9AAD.7060209@gmail.com> <m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 22:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Yrj-0005Mx-CP
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 22:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab1IXUaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 16:30:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:55466 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab1IXUaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 16:30:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R7YrN-0005GF-5T
	for git@vger.kernel.org; Sat, 24 Sep 2011 22:30:05 +0200
Received: from 31.64.20.37 ([31.64.20.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 22:30:05 +0200
Received: from a5158017 by 31.64.20.37 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 22:30:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 31.64.20.37
User-Agent: 40tude_Dialog/2.0.15.84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182041>

Jon Forrest wrote:

>> Generally Alice shouldn't have uncommitted changes when doing
>> "git pull".
> 
> That's what the tutorial said but I'm trying to understand
> what happens if she does have uncommitted changes. I'm
> trying to understand the total picture.

Mercurial allows this, and it's a very powerful feature.  After reading 
this thread, I could not believe Git didn't pulling with local changes, and 
so I tried it, and also asked on IRC -- and it seems that Git really 
doesn't.

If this is an important part of your workflow (as it is mine), I'd 
recommend using Mercurial if possible.
