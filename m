From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Fix signal handler
Date: Thu, 18 Feb 2010 17:31:54 +0100
Message-ID: <4B7D6B7A.1090004@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net> <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net> <7vsk94qfuy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 17:32:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni9Ie-0007Qj-Vy
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 17:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758143Ab0BRQcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 11:32:19 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:43650 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab0BRQcT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 11:32:19 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 070AA13EB0A30;
	Thu, 18 Feb 2010 17:31:54 +0100 (CET)
Received: from [78.49.129.221] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Ni9I9-0005qP-00; Thu, 18 Feb 2010 17:31:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7vsk94qfuy.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/oEEs/D5LBQ0VagaxOW2ddSH5dcoZOnuEfCUnG
	dQuSx37RNy+Tvq6OP7Nl2PSgUciOSFJPlsiC9oi3M8wG475con
	fGwhcb5hjVKUtQeUw08Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140350>


> Other than that, your comments all looked very sensible.
>   

Do you expect any more tweaks and fine-tuning for my update suggestion?

Regards,
Markus
