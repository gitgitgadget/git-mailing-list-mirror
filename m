From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Fix signal handler
Date: Fri, 19 Feb 2010 12:05:47 +0100
Message-ID: <4B7E708B.60006@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net> <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net> <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de> <7veikib96d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 12:05:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiQgH-0000At-EJ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 12:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab0BSLFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 06:05:51 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:33527 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab0BSLFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 06:05:51 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id D1354147F8E19;
	Fri, 19 Feb 2010 12:05:49 +0100 (CET)
Received: from [78.49.9.17] (helo=[192.168.1.202])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NiQg9-0001gL-00; Fri, 19 Feb 2010 12:05:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7veikib96d.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/D875w1yxfB/Jpu2qtVm07D2+Le9hbEoG/PIkg
	LzxTnQt6XrSLitok1Dt56fobDduJ7+GcbILeA32vpC1Dmvh/Dd
	/O4+vjF4Lz3lIPsD799A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140442>


> How would I be able to read your mind to see if you will decide to send a polished update?
>   

You indicated that my patch and the discussion about it was "not quite
ready yet" so far. I try to collect further suggestions for the next
refinement.

Regards,
Markus
