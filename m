From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4' 1/2] gitk: do not parse "  >" context as submodule
 change
Date: Tue, 20 Apr 2010 19:05:32 +0200
Message-ID: <4BCDDEDC.7040507@web.de>
References: <20100419010819.GA4386@brick.ozlabs.ibm.com> <671110fcac73c5fc8a935b82d88f8553c510c50c.1271694102.git.trast@student.ethz.ch> <4BCC9164.3080301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 20 19:05:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4GtQ-0000go-05
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 19:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab0DTRFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 13:05:41 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:52073 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab0DTRFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 13:05:40 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 978FC15E42E39;
	Tue, 20 Apr 2010 19:05:39 +0200 (CEST)
Received: from [80.128.80.210] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O4GtF-0001sE-00; Tue, 20 Apr 2010 19:05:37 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BCC9164.3080301@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18iystheKR77B4JoADz1fdlJll2ZMyRTULzlpnd
	ZkmijT3xdN/2T42YpS0b3MOsqGRHAKzWZTJLW9A247lfUnc2Kb
	vQ0C3D5UDFBGAQ6VM9rA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145390>

Am 19.04.2010 19:22, schrieb Jens Lehmann:
> Am 19.04.2010 18:27, schrieb Thomas Rast:
>>> Thanks, but now that I have applied Jens Lehmann's patch that also
>>> touches this area, your patch doesn't apply.  Could you rebase it and
>>> send it again?
>>
>> Sure.
> 
> There might be a problem with this rebase. Unfortunately I am very
> short on time, so I can't test this today.

I successfully tested this patch, this was a false alarm from my side.
Sorry for the noise.

Tested-by: Jens.Lehmann@web.de
