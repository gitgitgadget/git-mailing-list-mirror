From: Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com>
Subject: Re: Translation inclusion criteria
Date: Thu, 31 Mar 2011 10:16:46 -0300
Message-ID: <4D947EBE.5030708@gmail.com>
References: <4D889CC9.4060603@gmail.com>	<1301417951.13114.7.camel@drew-northup.unet.maine.edu>	<7vhbalrbwi.fsf@alter.siamese.dyndns.org> <4D9231F6.80205@gmail.com> <87tyekpxg5.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 15:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Hkk-0000mf-SH
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 15:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757664Ab1CaNQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 09:16:54 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37631 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757640Ab1CaNQw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 09:16:52 -0400
Received: by vxi39 with SMTP id 39so1819133vxi.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gsvTArv/9vf5rjLS6UDLNCJf6djOdJq3zdSVEl1WnWQ=;
        b=a+8xD9M7FqRffRvU5k27bTlXxJnlZcb+cjiiKEOzG6yVmLua0P88sD1gh9COyTsR9U
         5hxjdqxe2MqVsLwiYC1Rnp5zE8S5SzI+F4BpEapjbeSlBgMYnSjmd5m56PhEdDLAzQwl
         8/EdxnsJLKtfzsX2K4ADMhLQeB37GUa+mu4OM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=yAtwN89h4XNSSfPQ0G86K0rimOu4l9Z0XWsgWCaa1EXDEJWRuBNfan+iG2UU0jrge1
         Rrww5uaEUURdheAG+VdbcypGLpQ8fNAowy62dz/P1yserQ3a3H09vJzDFRlfaV2rjHuu
         Sc92tbDw0Kj8JLeLeBomWPqyf2HV21SZD6svw=
Received: by 10.52.68.100 with SMTP id v4mr3516885vdt.111.1301577410166;
        Thu, 31 Mar 2011 06:16:50 -0700 (PDT)
Received: from [192.168.2.236] (187.59.224.220.dynamic.adsl.gvt.net.br [187.59.224.220])
        by mx.google.com with ESMTPS id cc3sm294259vdb.24.2011.03.31.06.16.47
        (version=SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 06:16:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100918 Icedove/3.1.4
In-Reply-To: <87tyekpxg5.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170487>

  Em 30-03-2011 10:08, Pat Thoyts escreveu:
> Rodrigo Rosenfeld Rosas<rr.rosas@gmail.com>  writes:
>
>> Em 29-03-2011 15:59, Junio C Hamano escreveu:
>>> Drew Northup<drew.northup@maine.edu>   writes:
>>>
>>>> On Tue, 2011-03-22 at 09:57 -0300, Rodrigo Rosenfeld Rosas wrote:
>>>>> Hi, I've followed the instructions in git-gui/po/README in 2008 b=
ut
>>>>> pt.po was never included in master. Now I've just updated it.
>>>>>
>>>>> Is there anything else I should do for it being merged to master?=
 What
>>>>> is the criteria for including new translations?
>>>> ...
>>>> Rodrigo,
>>>> Internationalization of Git is very much an ongoing process. I sus=
pect
>>>> that has something to do with the uptake of your contribution. =C6=
var may
>>>> have more information.
>>> All the git-gui changes come through Pat Thoyts these days; =C6var =
has
>>> nothing to with git-gui i18n/l10n (except perhaps as a translator t=
o his
>>> own language, but I don't see his name in the shortlog).
>>>
>>> Perhaps the submission was sent with wrong Cc:; I don't pay attenti=
on to
>>> git-gui and gitk l10n patches myself.
>> Sorry, I think I'm missing something. From the mentioned README, it
>> seems we're supposed to push our changes to the mob branch of
>> mob@repo.or.cz:/srv/git/git-gui/git-gui-i18n.git/, which has write
>> access enabled for everyone.
>>
>> That's what I've done. I couldn't find any mention in the README abo=
ut
>> having to send some mail after that.
>>
>> I'll wait for instructions from Pat Thoyts to understand better what
>> should be my next step...
>>
>> Thanks,
>>
>> Rodrigo.
> It's best to just send a patch to me and this list based against one
> of the current branches (master/maint/pu). The i18n fork was done for
> the original work adding i18n to git-gui and hasn't been kept up to d=
ate
> since 2008.

Ok, thanks. I've just noticed pt_br.po was already included some days=20
ago on March 26 by Junio Hamano and it is up-to-date in the master bran=
ch.

But it would be great to update the README to replace those instruction=
s=20
regarding mob@repo.or.cz by the new instruction for sending the patches=
=20
by e-mail.

Best regards,

Rodrigo.
