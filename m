From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] tone down the detached head warning
Date: Thu, 01 Feb 2007 00:33:38 +0100
Organization: At home
Message-ID: <epr8u0$i7r$2@sea.gmane.org>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <epr8e9$i7r$1@sea.gmane.org> <20070131232748.GC31145@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 00:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCOwK-0001ix-UJ
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 00:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbXAaXc3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 18:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbXAaXc3
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 18:32:29 -0500
Received: from main.gmane.org ([80.91.229.2]:48749 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161077AbXAaXc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 18:32:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCOwA-00005k-Fv
	for git@vger.kernel.org; Thu, 01 Feb 2007 00:32:22 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 00:32:22 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 00:32:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38308>

Jeff King wrote:

> On Thu, Feb 01, 2007 at 12:25:14AM +0100, Jakub Narebski wrote:
> 
>>> git-checkout: note use of remote tracking branch when making detached warning
>>
>> You can checkout a tag, not a remote tracking branch!
> 
> Huh?

Ooops, I meant not _only_ a remote tracking branch (so note about detached
HEAD shouldn't talk about remote tracking branch unless we make sure that
it is remote tracking branch). Sorry.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
