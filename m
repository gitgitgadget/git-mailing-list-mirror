From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Tue, 28 Apr 2015 22:19:27 +0200
Message-ID: <553FEB4F.7050409@kdbg.org>
References: <553CD3DA.9090700@web.de>	<xmqqzj5uxhls.fsf@gitster.dls.corp.google.com>	<20150427061115.GB2766@camelia.ucw.cz> <553E86BD.7030401@kdbg.org>	<553E91CD.9060205@web.de> <553FD48B.1010608@kdbg.org> <xmqq7fswuj1s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stepan Kasal <kasal@ucw.cz>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	sandals@crustytoothpaste.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 22:19:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnByi-0005Wj-SF
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 22:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965926AbbD1UTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 16:19:32 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:56500 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965258AbbD1UTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 16:19:31 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lbvTD20Phz5tl9;
	Tue, 28 Apr 2015 22:19:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id A65475240;
	Tue, 28 Apr 2015 22:19:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqq7fswuj1s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267939>

Am 28.04.2015 um 21:52 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> I set none of these. But I do commit CRLF and expect to get CRLF
>> back. Am I commiting binary files? Am I doing something that "Git does
>> not support"? Am I "on [my] own"?
>
> I think these specific sentences are merely uninformed opinions; if
> I ignore and re-read what people said in the discussion, I think the
> thread as a whole makes sense.

Thanks for the clarification. Following the thread only superficially, I 
feared some behavior change (or even just a redefinition of what "is 
supported") is about to surface that impacts established workflows.

-- Hannes
