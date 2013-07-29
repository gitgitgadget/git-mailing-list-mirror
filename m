From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH gitk 0/4] gitk support for git log -L
Date: Mon, 29 Jul 2013 22:07:25 +0200
Message-ID: <51F6CB7D.1070806@web.de>
References: <cover.1370806329.git.trast@inf.ethz.ch> <874nblpamj.fsf@linux-k42r.v.cablecom.net> <874nbdnomj.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 29 22:07:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3tjF-0002dz-5m
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 22:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab3G2UHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 16:07:33 -0400
Received: from mout.web.de ([212.227.15.4]:51768 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144Ab3G2UHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 16:07:32 -0400
Received: from [192.168.178.41] ([91.3.155.21]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MOAmi-1UyQ5O1VyO-005Viu for <git@vger.kernel.org>;
 Mon, 29 Jul 2013 22:07:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <874nbdnomj.fsf@hexa.v.cablecom.net>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:zgS9gdP00my4WJi1CIg1RhYQ+9dfU1ZFkHwD/3gbIKpitHrjg4e
 1NKQ1xuSOTUq3KdlfxegIUeQnYbM7JavVidPTKs544tSlEOSIHsVDRFtfroLZ7NQkXgJNYl
 ECHwP9mzgebgfcKtmDE5zMV2ixiMvxlekHARe1dtHU9RDdt0Em/lotU6ukT8I2maSBd8WdM
 ym+KHW6GAqSKUX7qOEhrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231328>

Am 29.07.2013 21:37, schrieb Thomas Rast:
> Thomas Rast <trast@inf.ethz.ch> writes:
> 
>> Thomas Rast <trast@inf.ethz.ch> writes:
>>
>>> Now that git log -L has hit master, I figure it's time to discuss the
>>> corresponding change to gitk.
>>
>> Paul, any news on this?  Any chance we can get it into the next release,
>> since that will also be the first release to ship with 'git log -L'?
> 
> Jens pointed out privately that the handling of unstuck -L options is
> unfortunate, to put it mildly.  I'll send a reroll.

But as soon as that is fixed I'd really like to see this applied, as
I think gitk is the perfect tool to show history information.
