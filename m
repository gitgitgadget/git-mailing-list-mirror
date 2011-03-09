From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] rev-list-options.txt: typo fix
Date: Wed, 09 Mar 2011 08:07:43 +0100
Message-ID: <4D77273F.8040105@drmicha.warpmail.net>
References: <4D75E92C.1090506@drmicha.warpmail.net> <2862dfc9969beb42636ec44292d3509ddb215285.1299572814.git.git@drmicha.warpmail.net> <7vei6he68j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 08:11:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxDYC-000650-On
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 08:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab1CIHLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 02:11:11 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:40723 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751050Ab1CIHLL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2011 02:11:11 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 58BF1206FA;
	Wed,  9 Mar 2011 02:11:10 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 09 Mar 2011 02:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=NIxOIfcjKzvClrEcCqXQbozPT1U=; b=aauCuUqgV81PekPqtoLKwM+VBg0gnxX7c5lufo1IFgZbYDDV+FkAbkGzhRweHWuUGAbCmfrUWHaMY9kcHTFlRm+s3nwjYyVCRIE98srtDWI2grakumN6UzhORbcQE9zlDbOpkYZanfvQdZpHuc27JvTLe3gWVd0017cuP/ENo+k=
X-Sasl-enc: lRGYvZADQbhCyJ6XpmELx9iIjfTSevjnmDtPprYHF6Un 1299654670
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 28F27445A0A;
	Wed,  9 Mar 2011 02:11:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <7vei6he68j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168721>

Junio C Hamano venit, vidit, dixit 08.03.2011 20:56:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  Documentation/rev-list-options.txt |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index 95d209c..76add13 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -165,7 +165,7 @@ limiting may be applied.
>>  -n 'number'::
>>  --max-count=<number>::
>>  
>> -	Limit the number of commits output.
>> +	Limit the number of commits to output.
>>  
>>  --skip=<number>::
> 
> IIRC, the original was written using "output" as past particle of verb
> "output" (as "output" in "the commits are output"), so strictly speaking I
> don't think it is a typo.

When I switch on my "latin mode" I can recognize the participle in that
position, but only then ;)

> 
> But I like the new text better, so will apply ;-).
> 

With s/typo/grammo/ ;-)
