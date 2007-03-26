From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 19:31:18 +0200
Organization: At home
Message-ID: <eu8vrb$r15$1@sea.gmane.org>
References: <1174825838.12540.5.camel@localhost> <vpqvegpe4e1.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 19:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVt0A-0003rY-HF
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbXCZR2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318AbXCZR2r
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:28:47 -0400
Received: from main.gmane.org ([80.91.229.2]:45293 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305AbXCZR2q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:28:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HVszi-0008Hk-7D
	for git@vger.kernel.org; Mon, 26 Mar 2007 19:28:34 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 19:28:34 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 19:28:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43168>

Matthieu Moy wrote:

> Stupid question: why .gitlink, and not .git/link or so? This file is
> not versionned, I don't think it should be in the working tree.

It would be special-cased, as is .git directory not versioned, the
same way .gitlink would be not versioned (not like .gitignore).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
