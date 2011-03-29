From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 00/10] Docs: git tag
Date: Tue, 29 Mar 2011 08:25:34 +0200
Message-ID: <4D917B5E.1000600@drmicha.warpmail.net>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com> <7v8vvzyvdi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:29:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4SQY-0002ya-I7
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab1C2G3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 02:29:13 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41622 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496Ab1C2G3M (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 02:29:12 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 53AB020A1B;
	Tue, 29 Mar 2011 02:29:12 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 29 Mar 2011 02:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mDax1HlDHTO8VlJDZ9TynXlSHI4=; b=F3vX+AGCtFToBLnBYIvplxvS2JfapALv+R+sSXlifVWcYX1xIjbHhQt2ukxOo42Xr4JWUCmDMliRBnZz72AHOhknzkK8i9TCQReVCP6hO20RCkFS8hghPs7fwjWudQuhvHDnibTU568VXrb5nPCe7bFN+gAx+901uVmUi+ys6Dg=
X-Sasl-enc: bkssxSDeYtJT6JnfjiJYw6ZyQVO3uXAGzqOMdDfr78jI 1301380152
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A2711444203;
	Tue, 29 Mar 2011 02:29:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7v8vvzyvdi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170227>

Junio C Hamano venit, vidit, dixit 28.03.2011 20:04:
> Michael Witten <mfwitten@gmail.com> writes:
> 
>> Small patches fixing up the `git tag' docs.
>>
>> Michael Witten (10):
>>   Docs: git tag: Add `the'
>>   Docs: git tag: peoples back -> people's backs
>>   Docs: git tag: Revise a paragraph.
>>   Docs: git tag: other's -> the other person's
>>   Docs: git tag: Streamline a sentence.
>>   Docs: git tag: Add missing 'the'
>>   Docs: git tag: Use 'who' again
>>   Docs: git tag: Remove superfluous 'with'
>>   Docs: git tag: Use semicolon
>>   Docs: git tag: Rewrite discussion of GIT_COMMITTER_DATE
> 
> Thanks; all looked sensible changes, except for 7/10 which I somehow find
> the original is more readable than the new text, partly because the
> sentences are shorter but more importantly because the two sentences make
> two separate assertions (the first is about what "one-shot" pull means,
> the second is about why automatic tag following is not desired in that
> situation).

Looked mostly sensible to me (and I share Junio's view on 7), too,
although I probably would have changed "other's" simply to "others'".

And yes, while I like the dramatic sound of "behind peoples' backs",
you're absolutely right with "people's", of course:)

Those 10 patches could have been 1 actually, they are really divided
into atoms (which is not bad per se) even though they all fall under
"cosmetic language corrections and improvements" without any content
change nor restructuring.

Michael
