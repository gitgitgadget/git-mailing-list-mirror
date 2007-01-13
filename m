From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] merge-recursive: do not report the resulting tree object name
Date: Sat, 13 Jan 2007 01:57:43 +0100
Organization: At home
Message-ID: <eo9apg$sqo$1@sea.gmane.org>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com> <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com> <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net> <20070112184839.9431ddff.vsu@altlinux.ru> <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net> <7v8xg8t3aj.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701130034000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vbql3pxz8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jan 13 01:57:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5XDE-00019Z-M3
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 01:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbXAMA5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 19:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbXAMA5e
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 19:57:34 -0500
Received: from main.gmane.org ([80.91.229.2]:41405 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161182AbXAMA5d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 19:57:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5XD5-0005BI-Bd
	for git@vger.kernel.org; Sat, 13 Jan 2007 01:57:27 +0100
Received: from host-81-190-18-73.torun.mm.pl ([81.190.18.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Jan 2007 01:57:27 +0100
Received: from jnareb by host-81-190-18-73.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Jan 2007 01:57:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-73.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36735>

Junio C Hamano wrote:

> I do not think we need to show 1..15 at all, perhaps without
> "export GIT_MERGE_BASE_DEBUG=YesPlease".

Or a -v/--verbose (or even -v -v -v) flag set.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
