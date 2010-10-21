From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Oct 2010, #01; Wed, 13)
Date: Thu, 21 Oct 2010 04:14:30 +0200
Message-ID: <201010210414.30284.johan@herland.net>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 04:14:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8kft-0000Wr-FJ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 04:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873Ab0JUCOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 22:14:32 -0400
Received: from smtp.getmail.no ([84.208.15.66]:34148 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756775Ab0JUCOc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 22:14:32 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM00I01BK7YX80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:14:31 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 421D71EA57CB_CBFA207B	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:14:31 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id AED461EA28CF_CBFA206F	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:14:30 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM009E6BK63500@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:14:30 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159479>

On Thursday 14 October 2010, Junio C Hamano wrote:
> * jh/notes-merge (2010-10-09) 21 commits
>  [...]
> 
> Breaks build with arithmetic on (void *).

Fixed in the next iteration (v4, just posted). Thanks for noticing.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
