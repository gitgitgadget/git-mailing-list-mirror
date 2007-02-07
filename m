From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] add -C[NUM] to git-am
Date: Thu, 08 Feb 2007 00:54:51 +0100
Organization: At home
Message-ID: <eqdos9$4up$2@sea.gmane.org>
References: <20070207201511.GF12140@mellanox.co.il> <7vejp17m3t.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702080049330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 01:00:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwi3-0008LK-DS
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbXBHAAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422957AbXBHAAP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:00:15 -0500
Received: from main.gmane.org ([80.91.229.2]:51607 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422953AbXBHAAM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:00:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HEwhm-0002Dp-Em
	for git@vger.kernel.org; Thu, 08 Feb 2007 01:00:02 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 01:00:02 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 01:00:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39009>

Johannes Schindelin wrote:
> On Wed, 7 Feb 2007, Junio C Hamano wrote:
> 
>>  - we will be keeping applymbox after all.
> 
> Why? Does -am not do strictly more than applymbox?

>From documentation, it looks like applymbox can get signoff from a file,
and am not.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
