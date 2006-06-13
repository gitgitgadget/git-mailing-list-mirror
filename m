From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-cvsimport doesn't quite work, wrt branches
Date: Tue, 13 Jun 2006 19:06:13 +0200
Organization: At home
Message-ID: <e6mr9t$gjh$1@sea.gmane.org>
References: <87irn5ovn6.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 13 19:06:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqCLd-0001VG-5W
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 19:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWFMRGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 13:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWFMRGe
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 13:06:34 -0400
Received: from main.gmane.org ([80.91.229.2]:2254 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932200AbWFMRGd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 13:06:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FqCLF-0001Pz-4R
	for git@vger.kernel.org; Tue, 13 Jun 2006 19:06:13 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 19:06:13 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 19:06:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21786>

Jim Meyering wrote:

> Here's a test case that shows how git-cvsimport is misbehaving.
> The script below demonstrates the problem with git-1.3.3 as
> well as with 1.4.0.rc2.g5e3a6.  As for cvsps, I'm using version 2.1.

Do parsecvs has the same error?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
