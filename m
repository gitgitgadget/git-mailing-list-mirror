From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] notes: make expand_notes_ref globally accessible
Date: Tue, 08 Mar 2011 09:25:05 +0100
Message-ID: <201103080925.05761.johan@herland.net>
References: <20110307233902.GA20447@sigill.intra.peff.net>
 <20110307233956.GA20912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 09:25:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwsEG-0006UF-2g
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab1CHIZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 03:25:10 -0500
Received: from smtp.getmail.no ([84.208.15.66]:54397 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302Ab1CHIZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 03:25:09 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LHQ0042TCPVCN80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Mar 2011 09:25:07 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DEC2E1EA5564_D75E7E2B	for <git@vger.kernel.org>; Tue,
 08 Mar 2011 08:25:06 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A9DEC1EA278D_D75E7E2F	for <git@vger.kernel.org>; Tue,
 08 Mar 2011 08:25:06 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LHQ001N2CPUA100@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Mar 2011 09:25:06 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <20110307233956.GA20912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168639>

On Tuesday 08 March 2011, Jeff King wrote:
> This function is useful for other commands besides "git
> notes" which want to let users refer to notes by their
> shorthand name.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Johan Herland <johan@herland.net>


-- 
Johan Herland, <johan@herland.net>
www.herland.net
