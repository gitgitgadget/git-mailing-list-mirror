From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Mon, 21 May 2007 03:10:18 +0200
Organization: At home
Message-ID: <f2qr8h$cep$1@sea.gmane.org>
References: <200705170539.11402.andyparkins@gmail.com> <200705180857.18182.andyparkins@gmail.com> <200705181043.09203.Josef.Weidendorfer@gmx.de> <200705181021.30062.andyparkins@gmail.com> <20070518110804.GD4708@mellanox.co.il> <20070519125055.GQ942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 03:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpwLP-0000gS-JU
	for gcvg-git@gmane.org; Mon, 21 May 2007 03:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbXEUBFp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 21:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbXEUBFo
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 21:05:44 -0400
Received: from main.gmane.org ([80.91.229.2]:34737 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbXEUBFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 21:05:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HpwL6-0003zF-Uv
	for git@vger.kernel.org; Mon, 21 May 2007 03:05:32 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 May 2007 03:05:32 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 May 2007 03:05:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47957>

Sven Verdoolaege wrote:

> On Fri, May 18, 2007 at 02:08:04PM +0300, Michael S. Tsirkin wrote:
>> How about an ability for git-daemon to get commands with git-config?
> 
> You mean something like dump-config ?

Why not use tags, e.g. refs/tags/config tag to blob, or lightweight
tag to blob?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
