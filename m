From: Johan Herland <johan@herland.net>
Subject: Re: Directory replaced with a file confuses cherry-pick
Date: Fri, 18 Feb 2011 16:17:55 +0100
Message-ID: <201102181617.55929.johan@herland.net>
References: <op.vq3qtqtj56e9f9@xman.eng.oslo.osa>
 <201102181544.06045.johan@herland.net> <op.vq3sr8w956e9f9@xman.eng.oslo.osa>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Alexey Feldgendler <alexeyf@opera.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 16:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqS64-00078K-TR
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 16:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab1BRPSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 10:18:01 -0500
Received: from smtp.getmail.no ([84.208.15.66]:38277 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545Ab1BRPSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 10:18:00 -0500
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGT00I15JTWJUA0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 18 Feb 2011 16:17:56 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id AA5D21798F89_D5E8DA4B	for <git@vger.kernel.org>; Fri,
 18 Feb 2011 15:17:56 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 9473017961A4_D5E8DA4F	for <git@vger.kernel.org>; Fri,
 18 Feb 2011 15:17:56 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGT000FGJTWUD00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 18 Feb 2011 16:17:56 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <op.vq3sr8w956e9f9@xman.eng.oslo.osa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167218>

(please don't cull the CC list when replying)

On Friday 18 February 2011, Alexey Feldgendler wrote:
> On Fri, 18 Feb 2011 15:44:05 +0100, Johan Herland <johan@herland.net>
> 
> wrote:
> > Unable to reproduce. Here are the commands I used (please post yours):
> I tried your exact script now, line by line, and it failed in the way I
> described.
> 
> > This should not be the case. Which Git version are you using?
> 
> git is from Debian testing, package version 1:1.7.2.3-2.2.

I'm going away for the weekend, so I can't investigate this right now. Could 
you please retry with a more recent Git? Maybe someone else already knows 
which patch might have fixed this issue?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
