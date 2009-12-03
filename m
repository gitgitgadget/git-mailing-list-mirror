From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 03 Dec 2009 14:50:05 +0100
Message-ID: <m2d42w5fqq.fsf@igel.home>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
	<m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 14:50:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGC4a-00039i-HG
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 14:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422AbZLCNuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 08:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbZLCNuE
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 08:50:04 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:36723 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbZLCNuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 08:50:03 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id BE3811C00146;
	Thu,  3 Dec 2009 14:50:07 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 666AA90679;
	Thu,  3 Dec 2009 14:50:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id H3nQL3LJOSRv; Thu,  3 Dec 2009 14:50:06 +0100 (CET)
Received: from igel.home (DSL01.83.171.171.98.ip-pool.NEFkom.net [83.171.171.98])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu,  3 Dec 2009 14:50:06 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id EE58BCA28C; Thu,  3 Dec 2009 14:50:05 +0100 (CET)
X-Yow: Do you think the ``Monkees'' should get gas on odd or even days?
In-Reply-To: <4B17ABE3.6060003@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 03 Dec 2009 13:15:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134452>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Andreas Schwab venit, vidit, dixit 03.12.2009 13:03:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>>       Unconditionally set man.base.url.for.relative.links
>> 
>> rm -f git-add.1 && \
>>         xmlto -m manpage-normal.xsl  --stringparam man.base.url.for.relative.links= man git-add.xml
>> xmlto: unrecognized option '--stringparam'
>> make[1]: *** [git-add.1] Error 1
>> 
>> Andreas.
>> 
>
> and
>
> uname -a
> xmlto --version
>
> says?

xmlto version 0.0.18

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
