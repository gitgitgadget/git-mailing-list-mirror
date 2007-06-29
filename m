From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to share the same commits offline?
Date: Fri, 29 Jun 2007 18:09:29 +0200
Organization: At home
Message-ID: <f63aro$qnt$1@sea.gmane.org>
References: <46852503.8090407@cosmocode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 18:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4J2n-0003gE-DZ
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 18:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759086AbXF2QJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758920AbXF2QJ7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 12:09:59 -0400
Received: from main.gmane.org ([80.91.229.2]:57312 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758652AbXF2QJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 12:09:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I4J2a-0002cp-Md
	for git@vger.kernel.org; Fri, 29 Jun 2007 18:09:48 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jun 2007 18:09:48 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jun 2007 18:09:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51180>

[Cc: git@vger.kernel.org]

Tobias Sarnowski wrote:

> I am very happy with git and I am using it now on every project I
> develop, thanks Linus! My question is, how can I share objects with
> another repository without a direct connection?

Try git-bundle, since git version 1.5.1.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
