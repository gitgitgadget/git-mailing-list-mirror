From: "Andrew Timberlake-Newell" 
	<Andrew.Timberlake-Newell@AllianceOneInc.com>
Subject: RE: Handling renames.
Date: Thu, 14 Apr 2005 15:40:44 -0400
Message-ID: <002701c54129$da2ffdd0$9b11a8c0@allianceoneinc.com>
References: <425EC2E8.3010703@superlucidity.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Zach Welch'" <zw@superlucidity.net>,
	"'Linus Torvalds'" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:39:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMAAa-0001PE-P3
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVDNTlx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVDNTlx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:41:53 -0400
Received: from mail.allianceoneinc.com ([65.213.221.36]:18438 "EHLO
	mail.allianceoneinc.com") by vger.kernel.org with ESMTP
	id S261604AbVDNTlw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:41:52 -0400
Received: from epa20012 [192.168.17.155] by mail.allianceoneinc.com with ESMTP
  (SMTPD32-8.14) id A73D42440022; Thu, 14 Apr 2005 15:40:45 -0400
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
In-Reply-To: <425EC2E8.3010703@superlucidity.net>
X-IMAIL-SPAM-VALFROM: (c73d42440022f84f)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Zach Welch pontificated:
> I imagine quite a few folks expect something not entirely unlike an SCM
> to emerge from these current efforts. Moreover, Petr's 'git' scripts
> wrap your "filesystem" plumbing to that very end.
> 
> To avoid confusion, I think it would be better to distinguish the two
> layers, perhaps by calling the low-level plumbing... 'gitfs', of course.

Or perhaps to come up with a name (or at least nickname) for the SCM.

GitMaster?

