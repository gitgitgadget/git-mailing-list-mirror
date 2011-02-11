From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Challenges for an octopus merge
Date: Fri, 11 Feb 2011 17:23:27 +0100
Message-ID: <4D55627F.30305@web.de>
References: <4D53F694.1060105@web.de> <7v8vxn6fdv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 17:24:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnvn6-0007gw-G7
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 17:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757716Ab1BKQYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 11:24:10 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:44206 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195Ab1BKQYK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 11:24:10 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 53703187D0E3B;
	Fri, 11 Feb 2011 17:23:28 +0100 (CET)
Received: from [78.48.201.99] (helo=[192.168.1.46])
	by smtp04.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #2)
	id 1PnvmK-0002yg-00; Fri, 11 Feb 2011 17:23:28 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7v8vxn6fdv.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX18RPommEQ09E2LFUO1S7f8UpDcw5dvSFInjoVVa
	V9TyWPAWBin4+0SkZW9+D8HtK/ndiTh2NkbRcSurqefNHHFuh0
	iKf8Z66FLb6n077zG6GA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166563>

> The second-to-last line of the output needs to be rephrased.

Which wording adjustment have you got in mind?


> Octopus is not for recording conflicting merges and when it punts you
> shouldn't be attempting to resolve and record it as an octopus merge.

Would it make sense to specify that the merging process may switch to the
strategy "resolve" on demand?

Regards,
Markus
