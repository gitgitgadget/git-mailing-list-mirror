From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: installation instruction
Date: Sat, 23 Jun 2007 00:35:55 +0200
Organization: At home
Message-ID: <f5his8$ljh$1@sea.gmane.org>
References: <B4C61E6A632A7F4D8A414B71954E963105498C64@taz.delosps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 01:03:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1sAV-0002XR-70
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 01:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbXFVXDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 19:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbXFVXDx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 19:03:53 -0400
Received: from main.gmane.org ([80.91.229.2]:35537 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbXFVXDx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 19:03:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I1s1S-0005q9-UJ
	for git@vger.kernel.org; Sat, 23 Jun 2007 00:54:35 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jun 2007 00:54:34 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jun 2007 00:54:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50714>

[Cc: git@vger.kernel.org]

Sujatha Divi wrote:

> I want to install and evaluate git. Can anyone please direct me as to where
> I can get proper set of instructions for installation.

If you want to use newer version of git than in your distribution, and
RPMS and DEBs won't install because of dependencies (I for example --rebuild
RPM from SRPM, and install (re)build RPMs), there is [almost] always file
named INSTALL in the main directory.

See it also at:
  http://repo.or.cz/w/git.git?a=blob;f=INSTALL
  http://git.kernel.org/?p=git/git.git;a=blob;f=INSTALL

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
