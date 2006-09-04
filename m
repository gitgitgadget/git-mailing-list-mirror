From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-repack: clear out tmp packfiles from $PACKDIR instead of cwd
Date: Mon, 04 Sep 2006 10:17:11 +0200
Organization: At home
Message-ID: <edgndv$mtv$1@sea.gmane.org>
References: <11573485362686-git-send-email-martin@catalyst.net.nz> <46a038f90609032248h5eda61dft4150e13e49f8e59e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 04 10:39:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK9za-0002Sg-On
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 10:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWIDIjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 04:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWIDIjf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 04:39:35 -0400
Received: from main.gmane.org ([80.91.229.2]:49369 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932498AbWIDIRZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 04:17:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GK9do-0006vh-6x
	for git@vger.kernel.org; Mon, 04 Sep 2006 10:17:12 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 10:17:12 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 10:17:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26402>

Martin Langhoff wrote:

> On 9/4/06, Martin Langhoff <martin@catalyst.net.nz> wrote:
>> Temp packfiles should never be created in cwd anyway ;-)
> 
> Note! Applies after "git-repack: create new packs inside $PACKDIR, not cwd"
> 
>> VGER BF report: U 0.983488
> 
> Hilarious!

Isn't 'U' for Undecided? (and 'H' for Ham)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git



-- 
VGER BF report: S 0.999453
