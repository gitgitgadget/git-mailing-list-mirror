From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log and merge commits
Date: Mon, 14 May 2007 18:56:11 +0200
Organization: At home
Message-ID: <f2a42g$ein$2@sea.gmane.org>
References: <Pine.LNX.4.62.0705141803590.11269@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 18:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HndpR-0003fE-KV
	for gcvg-git@gmane.org; Mon, 14 May 2007 18:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbXENQzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 12:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171AbXENQzI
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 12:55:08 -0400
Received: from main.gmane.org ([80.91.229.2]:47877 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754877AbXENQzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 12:55:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Hndp8-0007W3-QY
	for git@vger.kernel.org; Mon, 14 May 2007 18:55:02 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 May 2007 18:55:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 May 2007 18:55:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47271>

[Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
     git@vger.kernel.org]

Geert Uytterhoeven wrote:

> I noticed `git log -p' doesn't show the changes introduced by merge commits.
> This is true for plain `git log -p' and for `git log -p <filename>'.

Have you tried `git log -p --cc'?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
