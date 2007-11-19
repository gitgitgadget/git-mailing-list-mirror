From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 14:29:23 +0100
Organization: At home
Message-ID: <fhs33j$eg9$1@ger.gmane.org>
References: <1195477504.8093.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 14:38:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6pT-0005wO-7I
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbXKSNiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbXKSNiE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:38:04 -0500
Received: from main.gmane.org ([80.91.229.2]:50044 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbXKSNiB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:38:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iu6kQ-0002na-8I
	for git@vger.kernel.org; Mon, 19 Nov 2007 13:33:10 +0000
Received: from abwr246.neoplus.adsl.tpnet.pl ([83.8.241.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 13:33:10 +0000
Received: from jnareb by abwr246.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 13:33:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwr246.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65443>

A few comments (from what I checked so far):

1. It is "man git-checkout" (or "git checkout --help"),
   not "man git checkout"

2. Instead of using 'verbatim' environment directly to show example CLI
   session it would be I think better to define verbatim-like environment
   for this ('example', 'commands', 'CLI', 'session'); perhaps replacing
   verbatim by lstlisting from the listings/lstlisting package for syntax
   highlighting.

I'll send more comments after reading it in full...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
