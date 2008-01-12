From: David Kastrup <dak@gnu.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 13:07:47 +0100
Message-ID: <85ejcn5jsc.fsf@lola.goethe.zz>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
	<200801120026.01930.robin.rosenberg@dewire.com>
	<1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org>
	<200801120115.41274.robin.rosenberg@dewire.com>
	<191B60D7-FD89-48D8-8D48-C91645D4814D@sb.org>
	<7v7iif28i2.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801120139170.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<B2968E86-D43E-4F5E-921F-DF8A15886C98@sb.org>
	<7vprw7zv7s.fsf@gitster.siamese.dyndns.org>
	<08E42D03-7AAA-4ADD-9F5B-215AB30E34E1@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 13:07:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDf8n-0002fm-OL
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 13:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761791AbYALMGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 07:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761530AbYALMGl
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 07:06:41 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:58360 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759431AbYALMGk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 07:06:40 -0500
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id CBF3D103986;
	Sat, 12 Jan 2008 13:06:38 +0100 (CET)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id B76CA2130A2;
	Sat, 12 Jan 2008 13:06:38 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-008-152.pools.arcor-ip.net [84.61.8.152])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 95E6A1C36A7;
	Sat, 12 Jan 2008 13:06:38 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4FD651C3E010; Sat, 12 Jan 2008 13:07:46 +0100 (CET)
In-Reply-To: <08E42D03-7AAA-4ADD-9F5B-215AB30E34E1@sb.org> (Kevin Ballard's
	message of "Fri, 11 Jan 2008 20:43:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/5478/Fri Jan 11 16:39:22 2008 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70310>

Kevin Ballard <kevin@sb.org> writes:

> On Jan 11, 2008, at 8:30 PM, Junio C Hamano wrote:
>
>>> Apparently so. By Junio's definition, HFS+ is not a sane filesystem,
>>> and as git grows more popular with OS X users, this issue is going to
>>> crop up more frequently.
>>
>> It's not "my" definition, but you asked the reason and I gave
>> the answer.  We can close this issue of "is HFS+ sane" now.
>> HFS+ is insane, period.  And as Linus said, you cannot forgive
>> its insanity using the historical baggage argument, like MS-DOS.
>
> Fair enough, though I believe OS X has a good reason, namely it's an
> OS designed for regular users rather than servers or
> programmers. Case-sensitivity would confuse my mother.

If case-sensitivity would be the primary cause of confusion in
mother-computer interoperation, you have a remarkable mother.

"Type things the same way and they work the same" is a simple enough
rule.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
