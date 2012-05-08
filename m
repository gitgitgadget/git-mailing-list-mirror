From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH resend] dir: convert to strbuf
Date: Tue, 08 May 2012 18:41:43 +0200
Message-ID: <4FA94CC7.5000104@lsrfire.ath.cx>
References: <4FA8CA98.9050708@lsrfire.ath.cx> <7vobpyy8g2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 18:42:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnU8-00008O-03
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab2EHQlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 12:41:55 -0400
Received: from india601.server4you.de ([85.25.151.105]:59253 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039Ab2EHQly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:41:54 -0400
Received: from [192.168.2.105] (p4FFDA45C.dip.t-dialin.net [79.253.164.92])
	by india601.server4you.de (Postfix) with ESMTPSA id C91A52F8092;
	Tue,  8 May 2012 18:41:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vobpyy8g2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197389>

Am 08.05.2012 17:54, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>
>> diff --git a/dir.c b/dir.c
>> index e98760c..c6a98cc 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -873,14 +873,14 @@ enum path_treatment {
>>   };
>>    static enum path_treatment treat_one_path(struct dir_struct *dir,
>
> How was this patch preprared?  It seems to have an extra SP after all=
 SP
> at the beginning of the line, which is a typical breakage pattern for
> patches sent in text/flawed, but is marked as text/plain.

Thunderbird, edit as new.  Can't trust that animal. :-/

Ren=C3=A9
