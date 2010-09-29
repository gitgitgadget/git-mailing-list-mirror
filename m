From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] checkout: add a space between the commit and "..."
Date: Wed, 29 Sep 2010 23:48:21 +0200
Message-ID: <m28w2kb4re.fsf@igel.home>
References: <20100928222332.GA28859@soprano.nvidia.com>
	<tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Plattner <aplattner@nvidia.com>, git@vger.kernel.org,
	jkain@nvidia.com
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 29 23:48:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P14Vr-0003T0-7a
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 23:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab0I2VsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 17:48:25 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:35576 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0I2VsY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 17:48:24 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 66C1F1C0050E;
	Wed, 29 Sep 2010 23:48:21 +0200 (CEST)
Received: from igel.home (ppp-88-217-126-240.dynamic.mnet-online.de [88.217.126.240])
	by mail.mnet-online.de (Postfix) with ESMTP id E4AA91C000B4;
	Wed, 29 Sep 2010 23:48:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id A5C31CA2A0; Wed, 29 Sep 2010 23:48:21 +0200 (CEST)
X-Yow: Why is it that when you DIE, you can't take your
 HOME ENTERTAINMENT CENTER with you??
In-Reply-To: <tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
	(Brandon Casey's message of "Tue, 28 Sep 2010 17:40:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157610>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> On 09/28/2010 05:23 PM, Aaron Plattner wrote:
>> Switching to a detached head prints something like
>> 
>>   HEAD is now at 9d14017... dir.c: squelch false uninitialized memory warning
>> 
>> These dots get selected when you double-click on the abbreviated
>> commit hash, which makes it annoying to copy and paste.
>
> This must be another gnome-terminal/konsole "innovation".

It's configurable in konsole at least (and not the default).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
