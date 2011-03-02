From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 0/7] Teach fetch/pull the on-demand mode and make it
 the default
Date: Thu, 03 Mar 2011 00:35:13 +0100
Message-ID: <4D6ED431.6090300@web.de>
References: <4D6D7A50.5090802@web.de> <4D6E6BB9.9000904@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 00:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuvZi-0001X0-Mf
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 00:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab1CBXfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 18:35:15 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:56483 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab1CBXfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 18:35:15 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id C329C18987B41;
	Thu,  3 Mar 2011 00:35:13 +0100 (CET)
Received: from [93.240.114.148] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PuvZZ-0001va-00; Thu, 03 Mar 2011 00:35:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D6E6BB9.9000904@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX183UdkEJT3xhnOE7VzdfwPBvNK42kdAqgznFG2T
	pSAfidFL3UwDl0TG1E+CUFTs2Gi5XomyRfSphBODaDy9wLBMHZ
	pva9ebXTA4C2kMobhtsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168363>

Am 02.03.2011 17:09, schrieb Marc Branchaud:
> On 11-03-01 05:59 PM, Jens Lehmann wrote:
>> *) Should this option be called "on-demand" or "changed" or maybe even
>>    "updated"?
>>    I have no strong feelings about this, me just thinks the name should
>>    tell somehow that only submodules where new commits are recorded in
>>    the superproject which aren't already present locally will be fetched.
>>    Opinions?
> 
> First, thanks again for this work!

Thanks for your feedback on this series, I'll include that in v3.

> I have a slight preference for "updated" or "updated-only", but no really
> strong feelings either way.

I'm looking forward to hear what others think ...
