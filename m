From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: Support for arbitrary diffs
Date: Mon, 03 Sep 2007 02:19:05 +0200
Organization: At home
Message-ID: <fbfjtl$7gh$1@sea.gmane.org>
References: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 02:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzfE-0002qZ-Go
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512AbXICATY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 20:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933639AbXICATX
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:19:23 -0400
Received: from main.gmane.org ([80.91.229.2]:59642 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933469AbXICATU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:19:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IRzeq-0004pn-PU
	for git@vger.kernel.org; Mon, 03 Sep 2007 02:19:12 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 02:19:12 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 02:19:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57413>

[Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
     Petr Baudis <pasky@suse.cz>, git@vger.kernel.org]

Martin Koegler wrote:

> Patch 4 now only generates the links, if they are enabled.
> The header contains a new link to show/hide the links.
> The state is remembered via a cookie across pages.

I'd rather have patch adding cookie management (are they only JavaScript,
or also server side?) as a separate patch.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
