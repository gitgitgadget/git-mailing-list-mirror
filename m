From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using Filemerge.app as a git-diff viewer
Date: Wed, 21 Nov 2007 14:58:09 +0100
Organization: At home
Message-ID: <fi1dhg$eb5$1@ger.gmane.org>
References: <47440912.8010800@cam.ac.uk> <20071121112757.GA17231@sigill.intra.peff.net> <1A9343EE-BB45-4CF8-9F17-E6A73C5F0B83@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 14:59:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuq6Z-0000Qu-JH
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 14:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbXKUN6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 08:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbXKUN6q
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 08:58:46 -0500
Received: from main.gmane.org ([80.91.229.2]:40305 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbXKUN6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 08:58:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iuq5z-0007kl-7u
	for git@vger.kernel.org; Wed, 21 Nov 2007 13:58:27 +0000
Received: from abxf19.neoplus.adsl.tpnet.pl ([83.8.255.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 13:58:27 +0000
Received: from jnareb by abxf19.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 13:58:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxf19.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65650>

Wincent Colaiuta wrote:

> - you need to escape those $-signs

[...]

> $ cat >merge.sh <<EOF

Or use

$ cat >merge.sh <<\EOF

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
