From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 15:45:49 +0000 (UTC)
Message-ID: <pan.2007.05.19.15.45.46@progsoc.org>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net>
	<20070519115245.GA10035@coredump.intra.peff.net>
	<20070519120933.GW17511@curie-int.orbis-terrarum.net>
	<20070519121154.GA10268@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 17:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpR8I-0005HO-Bt
	for gcvg-git@gmane.org; Sat, 19 May 2007 17:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759335AbXESPqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 11:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759337AbXESPqG
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 11:46:06 -0400
Received: from main.gmane.org ([80.91.229.2]:46208 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759335AbXESPqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 11:46:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HpR84-0004Qq-GU
	for git@vger.kernel.org; Sat, 19 May 2007 17:46:00 +0200
Received: from 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk ([82.35.82.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 May 2007 17:46:00 +0200
Received: from wildfire by 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 May 2007 17:46:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk
User-Agent: Pan/0.125 (Potzrebie)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47751>

On Sat, 19 May 2007 08:11:54 -0400, Jeff King wrote:

> On Sat, May 19, 2007 at 05:09:33AM -0700, Robin H. Johnson wrote:
> 
>> Ahh, they do show up there (and I learnt a new git command now, thanks)
>> - the ones that I can remember the Subject lines for anyway.
>> 
>> Any hints for the future on finding stuff that is in the reflog but not
>> in the tree? (Remembering every subject line isn't feasible).
> 
> Try 'git-fsck --unreachable --no-reflogs'. :)

What version? git 1.5.1.4 doesn't seem to have that.

Anand
