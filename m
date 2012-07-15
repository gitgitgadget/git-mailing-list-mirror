From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] doc: A few minor copy edits.
Date: Sun, 15 Jul 2012 11:43:17 +0200
Message-ID: <87wr25nyve.fsf@gmail.com>
References: <1342304436-29499-1-git-send-email-stepnem@gmail.com>
	<7vehod614a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 11:44:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqLN6-0002MQ-T2
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 11:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab2GOJnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jul 2012 05:43:25 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45565 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab2GOJnX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2012 05:43:23 -0400
Received: by wgbdr13 with SMTP id dr13so98192wgb.1
        for <git@vger.kernel.org>; Sun, 15 Jul 2012 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=qa7HLtDFMtuvtxFBVrmJc29j+IIEDKIDZrgg5ZuMGeo=;
        b=t016rd+AenNUmmzwMNU+dJZkJYMQrqmtrRnvi6BErxVCWvUAk26aHUncYlWc6aZWTk
         BUBm5dDmt+gEZkaRgBXyFGb0zELB0r2Ish44/MIoeoOSuXR+UMGC2p0GO/bPWKiY0Izi
         Fp8s4r9AAQDp9CQpu06lHJmmNQSQsen33MDVCc8PShwO+38YE5u6DwTktWabr0GCrz8S
         4glVEo1N5JT8bw20B42IjLLACnSyid+3L4mIHjGFbeZIMt9s1r99QFkPQGjO2i8S0Z1N
         Kg96RIPikaO585nd8sEiw/rzOSXFuKlspCufvytnnlzaP9AVOzqDIM9ZLoGT6wi1QuGU
         UCdA==
Received: by 10.180.102.136 with SMTP id fo8mr9900814wib.19.1342345401669;
        Sun, 15 Jul 2012 02:43:21 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz. [90.177.119.176])
        by mx.google.com with ESMTPS id eu4sm14653229wib.2.2012.07.15.02.43.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jul 2012 02:43:20 -0700 (PDT)
In-Reply-To: <7vehod614a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 14 Jul 2012 22:32:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201476>

On Sat, 14 Jul 2012 22:32:05 -0700
Junio C. Hamano wrote:

> Thanks.  All looked reasonable, except that I've heard nobody says
> "ent" for the past couple of years, and it might be better to drop
> the entry altogether.

Yeah, I have no real opinion here. I've never been a Tolkien fan, so I
had no idea what "ent" even means, let alone its connection to anything
Git-related (which is why the glossary entry caught my eye in the first
place). I found it amusing and that's all; maybe other Git oldtimers
have some kind of personal attachment to it?

I have to admit that I don't remember seeing the word in any of various
Git-related texts or discussions I've read in past ~3 years, so I agree
its educative value is probably dubious nowadays. OTOH it's just a
couple lines, _and_ amusing... ;-)

I'll resend the patch with the entry removed if no break-through occurs
during the next few days.

>> diff --git a/Documentation/glossary-content.txt b/Documentation/glos=
sary-content.txt
>> index 3595b58..f928b57 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -117,7 +117,7 @@ to point at the new commit.
>> =20
>>  [[def_ent]]ent::
>>  	Favorite synonym to "<<def_tree-ish,tree-ish>>" by some total geek=
s. See
>> -	`http://en.wikipedia.org/wiki/Ent_(Middle-earth)` for an in-depth
>> +	http://en.wikipedia.org/wiki/Ent_(Middle-earth) for an in-depth
>>  	explanation. Avoid this term, not to confuse people.
>> =20
>>  [[def_evil_merge]]evil merge::

--=20
=C5=A0t=C4=9Bp=C3=A1n
