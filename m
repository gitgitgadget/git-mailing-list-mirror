From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: bugfix: commitdiff regression
Date: Fri, 18 Aug 2006 00:11:22 +0200
Organization: At home
Message-ID: <ec2pgb$3ml$1@sea.gmane.org>
References: <20060817220037.22377.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 18 00:11:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDq4p-0007aE-HI
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 00:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWHQWK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 18:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWHQWK4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 18:10:56 -0400
Received: from main.gmane.org ([80.91.229.2]:17050 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030220AbWHQWKy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 18:10:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDq4Z-0007Vg-Oa
	for git@vger.kernel.org; Fri, 18 Aug 2006 00:10:43 +0200
Received: from host-81-190-26-94.torun.mm.pl ([81.190.26.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 00:10:43 +0200
Received: from jnareb by host-81-190-26-94.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 00:10:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-94.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25615>

Luben Tuikov wrote:

> Fix regression in git_commitdiff() introduced
> by commit 756d2f064b2419fcdf9cd9c851f352e2a4f75103.
> 
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Could you please attach patches inline, and if it is not possible due to
whitespace munging, at least attach them as text/plain with 8bit encoding,
not base64 encoding?

TIA

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
