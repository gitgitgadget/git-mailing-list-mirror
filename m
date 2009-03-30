From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv2 4/4] Rename push.default to push.mode
Date: Mon, 30 Mar 2009 14:37:52 +0200
Message-ID: <adf1fd3d0903300537i41d4aef3g49ab6bde9343cbc5@mail.gmail.com>
References: <1238407903-28020-1-git-send-email-santi@agolina.net>
	 <1238407903-28020-5-git-send-email-santi@agolina.net>
	 <49D0A1FE.60300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 14:39:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoGm5-0006rP-4m
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 14:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbZC3Mh4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 08:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZC3Mh4
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 08:37:56 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:34731 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbZC3Mhz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 08:37:55 -0400
Received: by mu-out-0910.google.com with SMTP id g7so852791muf.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 05:37:52 -0700 (PDT)
Received: by 10.102.228.10 with SMTP id a10mr1680319muh.26.1238416672281; Mon, 
	30 Mar 2009 05:37:52 -0700 (PDT)
In-Reply-To: <49D0A1FE.60300@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115144>

2009/3/30 Michael J Gruber <git@drmicha.warpmail.net>:
> Santi B=E9jar venit, vidit, dixit 30.03.2009 12:11:
>> push.default was too generic, and also didn't specify if it was abou=
t
>> remote, refspec, branches, behaviour...
>
> I guess we go for US spelling here, so it's "behavior" ;)

Ok.

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 38ab785..80bb3a6 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -480,7 +480,7 @@ branch.<name>.remote::
>>  branch.<name>.merge::
>>       It defines, together with branch.<name>.remote, the upstream b=
ranch
>>       for the given branch. It tells 'git-fetch'/'git-pull' which
>> -     branch to merge and can also afect 'git-push' (see push.defaul=
t).
>> +     branch to merge and can also afect 'git-push' (see push.mode).
>
> s/afect/affect/
>

OK

>
> Your patches contain quoted-printable characters all over the place.

I don't see the quoted-printable characters, I see them in utf-8 and 8b=
it.

Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Maybe some server in between is recoding it.

> Are
> they not sent with git send-email?

They are send with git send-email and msmtp.

Santi
