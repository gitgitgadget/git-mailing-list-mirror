From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: t9200-git-cvsexportcommit.sh failed on CYGWIN
Date: Thu, 28 Dec 2006 12:54:29 +0100
Organization: At home
Message-ID: <en0b47$bjm$3@sea.gmane.org>
References: <459338AA.8000407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Dec 28 12:55:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gztqt-0003yH-8h
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 12:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbWL1LzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 06:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbWL1LzM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 06:55:12 -0500
Received: from main.gmane.org ([80.91.229.2]:35412 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754821AbWL1LzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 06:55:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gztqg-00078A-BT
	for git@vger.kernel.org; Thu, 28 Dec 2006 12:55:02 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 12:55:02 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 12:55:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35556>

[Cc: git@vger.kernel.org]

SungHyun Nam wrote:

> Below is the test messages.
> 
> BTW, I hope I can define 'NO_CVS_TESTS' to skip this test.
[...]
> *   ok 7: Update file with spaces in file name
> * FAIL 8: File with non-ascii file name
>         mkdir -p

What filesystem? Some filesystems are just broken...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
