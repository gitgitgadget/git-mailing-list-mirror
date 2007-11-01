From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Implement git commit as a builtin command.
Date: Thu, 01 Nov 2007 21:14:45 +0100
Organization: At home
Message-ID: <fgdc3m$miq$1@ger.gmane.org>
References: <1193944163-22892-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 21:15:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IngRc-0004Fv-4A
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 21:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbXKAUO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 16:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbXKAUO5
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 16:14:57 -0400
Received: from main.gmane.org ([80.91.229.2]:52568 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbXKAUO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 16:14:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IngRH-0006vc-Qi
	for git@vger.kernel.org; Thu, 01 Nov 2007 20:14:51 +0000
Received: from abvb125.neoplus.adsl.tpnet.pl ([83.8.199.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 20:14:51 +0000
Received: from jnareb by abvb125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 20:14:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvb125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62987>

Kristian H?gsberg wrote:

> Move git-commit.sh to contrib/examples.

Just a note: you might want to use "git format-patch -M".

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
