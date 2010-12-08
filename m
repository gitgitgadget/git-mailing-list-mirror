From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Wed, 08 Dec 2010 22:35:01 +0100
Message-ID: <4CFFFA05.6070609@web.de>
References: <20101201171814.GC6439@ikki.ethgen.de> <20101201185046.GB27024@burratino> <4CF80B71.3010309@web.de> <7vipz5nqd0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>, mlevedahl@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 22:37:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQRhE-00069M-7s
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 22:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab0LHVhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 16:37:04 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:35075 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab0LHVgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 16:36:19 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id D1F7D18123C52;
	Wed,  8 Dec 2010 22:35:01 +0100 (CET)
Received: from [93.246.45.238] (helo=[192.168.178.51])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PQRfB-0006Da-00; Wed, 08 Dec 2010 22:35:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7vipz5nqd0.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19OtijezUNyVX+rspu13ZKvDEyp9/AjLSoJd/v1
	nQ7P+6xQY2aRlUD/C2EpqOfJooEAtphxpPPMjwhJkk4LGzruWa
	znvqUxEy9jeHFAy71qJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163224>

Am 07.12.2010 23:57, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Nope, these lines date back to the time before I got involved in the
>> submodule business ... Seems like this "git checkout" was added in
>> March 2008 by Mark Levedahl (CCed), maybe he can shed some light on
>> that.
>>
>> But to me your change looks good, so feel free to add:
>> Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
> 
> Does either of you want to add a test for this?

Will do.
