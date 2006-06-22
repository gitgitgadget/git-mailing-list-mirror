From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Subject: Re: git pull w/o checkout?
Date: 22 Jun 2006 15:34:25 +0200
Organization: Uh?
Message-ID: <m37j39gvq6.fsf@bigip.bigip.mine.nu>
References: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org>
	<20060622131129.GB5134@spinlock.ch>
	<6F96D77C-FE27-4B74-ADBF-9964B5FD72DF@kernel.crashing.org>
	<20060622131730.GB7168@coredump.intra.peff.net>
	<6C519A4B-9253-49BB-BF68-DCD557DACCB7@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 15:36:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtPLr-0000eU-KE
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWFVNgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWFVNgE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:36:04 -0400
Received: from mx1.lost-oasis.net ([212.85.153.8]:22449 "EHLO
	mx1.lost-oasis.net") by vger.kernel.org with ESMTP id S1161122AbWFVNgC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 09:36:02 -0400
Received: from amarseille-252-1-159-1.w86-216.abo.wanadoo.fr ([86.216.118.1] helo=bigip.bigip.mine.nu)
	by mx1.lost-oasis.net with asmtp (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA:24)
	(Exim 4.34)
	id 1FtPom-0006Ht-8F; Thu, 22 Jun 2006 16:06:00 +0200
Received: from bigip.bigip.mine.nu (bigip [127.0.0.1])
	by bigip.bigip.mine.nu (8.13.6/8.13.6) with ESMTP id k5MDYPgs030398;
	Thu, 22 Jun 2006 15:34:25 +0200
Received: (from mchouque@localhost)
	by bigip.bigip.mine.nu (8.13.6/8.13.6/Submit) id k5MDYPlD030395;
	Thu, 22 Jun 2006 15:34:25 +0200
X-Authentication-Warning: bigip.bigip.mine.nu: mchouque set sender to ml2news@free.fr using -f
To: galak@kernel.crashing.org (Kumar Gala)
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
In-Reply-To: <6C519A4B-9253-49BB-BF68-DCD557DACCB7@kernel.crashing.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22340>

galak@kernel.crashing.org (Kumar Gala) writes:
> Ahh, I see.  I can than just copy the 'origin' ref over 'master'.

Or use git fetch -u ? 

-- 
Mathieu Chouquet-Stringer                     mchouque@free.fr
