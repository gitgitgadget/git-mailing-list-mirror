From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Clarifications for merge workflows
Date: Thu, 11 Mar 2010 14:02:04 +0100
Message-ID: <4B98E9CC.9000700@web.de>
References: <4B98D015.40401@web.de> <7v63532h82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 14:02:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npi1p-0004UN-QE
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757851Ab0CKNCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 08:02:12 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:56042 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757764Ab0CKNCL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:02:11 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id C814214C8668A;
	Thu, 11 Mar 2010 14:02:09 +0100 (CET)
Received: from [78.48.136.139] (helo=[192.168.1.2])
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1Npi1h-000499-00; Thu, 11 Mar 2010 14:02:09 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7v63532h82.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19GUQn1CpITfekluM0zwrqv0RPWmNTOVGl3PkGj
	qAycoy1G1tT3+eBj8Xo8Ojlyiu/yshvhCIn7XGSY58ZR/QFKm0
	qfqZNVcHdYZN+l+r9VuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141960>

Thanks for your explanation.


> And then the procedure to publish the result out, whether it is what I did
> myself, or what I helped to integrate into my history from others, is the
> same.  I push the result out from that "local" place to the "public" one.

Does any observable difference exist if the data synchronisation would be
performed in the other direction?


> Of course, if you are always working on that "server", the fact that you
> are always working there makes it the most convenient place to do all of
> your work for you.

I guess that it matters a bit if the published repository "SHARE" is the leading
and authoritative storage location.

Regards,
Markus
