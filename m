From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] t9155: fix compatibility with older SVN
Date: Mon, 23 Aug 2010 18:22:59 +0200
Message-ID: <4C72A063.3010003@web.de>
References: <4C6D6274.90009@web.de> <AANLkTiky8qn_PSgXSn=0h07cb4VmCFiFXmD9WrpO1z6z@mail.gmail.com> <20100819191425.GA1543@dcvr.yhbt.net> <20100819191552.GB1543@dcvr.yhbt.net> <4C6D8898.1040907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r?= =?ISO-8859-1?Q?=F0_Bjarmason?= 
	<avarab@gmail.com>, "David D. Kilzer" <ddkilzer@kilzer.net>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 23 18:23:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnZnj-00083q-F5
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 18:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab0HWQXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 12:23:05 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:49082 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab0HWQXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 12:23:04 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id A75F416E7C8F2;
	Mon, 23 Aug 2010 18:23:02 +0200 (CEST)
Received: from [93.246.62.127] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OnZna-0008GE-00; Mon, 23 Aug 2010 18:23:02 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C6D8898.1040907@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18234gfEaYs6bIYeMioB6FoblyH1rxxmZvQHiGl
	NhPGBzNWEHMCvbFGq79dD2YLMZANCfLyNayG/45kbOm/2Bt/3N
	Cyv8guqEiB+7ZFZ0UFUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154233>

Am 19.08.2010 21:40, schrieb Jens Lehmann:
> Am 19.08.2010 21:15, schrieb Eric Wong:
>> The "--parents" option did not appear until SVN 1.5.x
>> and is completely unnecessary in this case.
> 
> Thanks for the quick response! I'll test this patch on Monday when
> I have access to that FC7 machine again.

Just for the record:

Tested-By: Jens Lehmann <Jens.Lehmann@web.de>
