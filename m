From: =?UTF-8?B?QW5kcsOpIFdhbGtlcg==?= <andre@andrewalker.net>
Subject: Re: majordomo subscription woes
Date: Tue, 20 Mar 2012 15:42:41 -0300
Message-ID: <4F68CFA1.8020401@andrewalker.net>
References: <001636c5c21b02c35904bba0ff9a@google.com> <201203201637.10417.jnareb@gmail.com> <7v62dz6v5c.fsf@alter.siamese.dyndns.org> <201203201844.55155.jnareb@gmail.com> <20120320175422.GA20669@sigill.intra.peff.net> <4F68C5E4.3050306@andrewalker.net> <20120320181857.GA20804@sigill.intra.peff.net> <4F68CBC4.1010507@andrewalker.net> <20120320183246.GA21429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 19:43:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA41W-0006rW-3T
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 19:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab2CTSnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 14:43:04 -0400
Received: from oproxy5-pub.bluehost.com ([67.222.38.55]:37370 "HELO
	oproxy5-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755430Ab2CTSnC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 14:43:02 -0400
Received: (qmail 18501 invoked by uid 0); 20 Mar 2012 18:43:02 -0000
Received: from unknown (HELO host245.hostmonster.com) (74.220.215.245)
  by cpoproxy2.bluehost.com with SMTP; 20 Mar 2012 18:43:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=andrewalker.net; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=kxO7ymXYtRm8GQeEal/SCxj83yaLpTJd9wBKu3tOJ/I=;
	b=fqR+GcKfcRaw0/s3M5ha35gWoALRWPSvHPYUyAhZUK/k7cHglG1CdLpGIzvSi+262xQQvPBifEKgzcUnNwlMc5+1BCxCp4UDYYo4C611XtmeON0FCshrZCnaEOGN0biC;
Received: from tor-exit-router36-readme.formlessnetworking.net ([199.48.147.36] helo=[0.0.0.0])
	by host245.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <andre@andrewalker.net>)
	id 1SA41M-0003nS-5F; Tue, 20 Mar 2012 12:43:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
In-Reply-To: <20120320183246.GA21429@sigill.intra.peff.net>
X-Identified-User: {2744:host245.hostmonster.com:picloadc:andrewalker.net} {sentby:smtp auth 199.48.147.36 authed with andre@andrewalker.net}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193535>

On 03/20/2012 03:32 PM, Jeff King wrote:
> On Tue, Mar 20, 2012 at 03:26:12PM -0300, Andr=C3=A9 Walker wrote:
>
>> On 03/20/2012 03:18 PM, Jeff King wrote:
>>> It sounds like you are doing it right. And your emails look OK to m=
e
>>> (and the list is accepting them when cc'd). Your original mails may=
 have
>>> been greylisted, and waiting on your mail server to re-send them.
>>> Depending on how your mail server is configured, that might be a fe=
w
>>> minutes or a few hours. How long ago did you try?
>> Right. The first time was more than 11 hours ago, and the second 1
>> hour ago. Is there a list administrator who can whitelist my address=
?
> We can ask postmaster@vger, but before we do that, there's one more
> thing to check.  Majordomo will send a confirmation email with a code=
 in
> it. Can you check on your end that majordomo's response email wasn't
> blocked as spam?
Yes, I re-checked that now to be sure, and there's nothing from=20
majordomo there.
