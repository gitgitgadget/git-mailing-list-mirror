From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about
 shared repositories
Date: Wed, 07 Nov 2007 09:45:12 +0100
Message-ID: <47317B18.7000804@op5.se>
References: <472F99F8.4010904@gmail.com> <7v8x5cmern.fsf@gitster.siamese.dyndns.org> <4730E056.7080809@gmail.com> <7vd4unez2l.fsf@gitster.siamese.dyndns.org> <47310ACF.4030103@gmail.com> <Pine.LNX.4.64.0711070053320.4362@racer.site> <3abd05a90711061736r4c969cddj348c006615ffbdd6@mail.gmail.com> <DED2A61B-B5AE-4BAA-942A-18A61924611E@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Aghiles <aghilesk@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Francesco Pretto <ceztkoml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:45:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpgXZ-0007GR-M8
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbXKGIpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 03:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbXKGIpW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:45:22 -0500
Received: from mail.op5.se ([193.201.96.20]:45364 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755401AbXKGIpV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 03:45:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 75AEE1730667;
	Wed,  7 Nov 2007 09:44:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdMIOR1M6Dhy; Wed,  7 Nov 2007 09:44:46 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 05AC51730674;
	Wed,  7 Nov 2007 09:44:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <DED2A61B-B5AE-4BAA-942A-18A61924611E@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63788>

Steffen Prohaska wrote:
>  BTW, useradd and such
> would not help me at all, because I need to talk to my admin
> anyway and he adds an account to the LDAP database.
> 

I suspect this is the case for most companies looking to switch
to git. It certainly is here. Personally, I tend to find documents
stooping to toddler-level a bit insulting unless they're marked
as "walkthrough" or "for beginners" or some such. Especially if
they are obviously not correct for all environments.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
