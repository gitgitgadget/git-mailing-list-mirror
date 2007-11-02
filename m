From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] New script: git-changelog.perl
Date: Fri, 02 Nov 2007 18:07:57 +0100
Organization: At home
Message-ID: <fgflce$aea$1@ger.gmane.org>
References: <67837cd60711020855v5badf7a6o9b777f339df070f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 18:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inzy3-0004Y8-Ez
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 18:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbXKBRFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758835AbXKBRFo
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 13:05:44 -0400
Received: from main.gmane.org ([80.91.229.2]:55114 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758826AbXKBRFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 13:05:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Inzxf-00077J-21
	for git@vger.kernel.org; Fri, 02 Nov 2007 17:05:35 +0000
Received: from abvq154.neoplus.adsl.tpnet.pl ([83.8.214.154])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 17:05:35 +0000
Received: from jnareb by abvq154.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 17:05:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq154.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63144>

[Cc: Ronald Landheer-Cieslak <ronald@landheer-cieslak.com>, 
 git@vger.kernel.org]

Ronald Landheer-Cieslak wrote:

> I've written a little script that will format the changes as reported
> by git-log in a ChangeLog-like format. Entries look like this:
> <date>\t<author>\n\t<sha1>: <subject>

How it compares to existing git2cl tool?:
  http://josefsson.org/git2cl/
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

BTW. Do anyone has idea why on above wiki page table of contents does not
display some sections at all?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
