From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: files missing after converting a cvs repository to git
Date: Tue, 07 Oct 2008 12:15:12 +0200
Organization: At home
Message-ID: <gcfcrg$ubc$1@ger.gmane.org>
References: <799406d60810061502y417ec53o1a1f5cef800dfe45@mail.gmail.com> <48EAFCEF.8030907@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 12:16:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn9cJ-00011P-PZ
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 12:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbYJGKPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 06:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbYJGKPX
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 06:15:23 -0400
Received: from main.gmane.org ([80.91.229.2]:52523 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbYJGKPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 06:15:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kn9b6-0006M7-Lq
	for git@vger.kernel.org; Tue, 07 Oct 2008 10:15:20 +0000
Received: from abvf55.neoplus.adsl.tpnet.pl ([83.8.203.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 10:15:20 +0000
Received: from jnareb by abvf55.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 10:15:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvf55.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97687>

Andreas Ericsson wrote:

> cvs2svn is apparently quite good at getting even the weirdest history
> right. Perhaps you can try that and then running "git svn" on the
> resulting svn repo?

cvs2svn has git output now (I think it is actually fast-import output)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
