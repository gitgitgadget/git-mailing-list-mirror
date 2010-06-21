From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #03; Fri, 18)
Date: Tue, 22 Jun 2010 00:10:59 +0530
Message-ID: <AANLkTilINSK78ds1A3ZK1kdqlHf8S-lLrVboabsQLua_@mail.gmail.com>
References: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
	<AANLkTinB4N6xXm7_Locp-xJyN8Nkew_7t16XhjVi_GlB@mail.gmail.com>
	<7v7hltvcfy.fsf@alter.siamese.dyndns.org>
	<AANLkTiksOHr2m4HCPp8779VG95zexvYwgE86MsFzBJxF@mail.gmail.com>
	<7v631ci6ex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 20:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQlvs-0006NN-6l
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 20:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab0FUSlD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 14:41:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52974 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab0FUSlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jun 2010 14:41:00 -0400
Received: by gye5 with SMTP id 5so2406279gye.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7HXceA+95Tt6aMiMz3VOCFR4GDHzv1+se4k9H10ukwU=;
        b=HXEUwHJC5HVQc2Wu2QfhKU7kwE79CKyIbjZHepCFVtTSlOcQZ7NirO4GYlBeh3aMUo
         jJFWlC+2tbPRTpc1CHQw2JXIYYgCk1xfwEyer5er7op/U3R5o9NNcNuXtdK/9vle9ifU
         IQujIZDO9kcbXn4Hn+G6C5XOBfmxkUnobQz2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f3b5UA1mrHhSUhsAP5BoWylP7kIHrM9gztYtrR8R+AzB7p1ZQOsQ4bM9wFcX7QGgbm
         NRdxjmKSYhPMOKQO0oqjZ+hEcVPfmRxDFOJjOYqDTp9m9Mj6YQ8Hd30rS2vS1AO3KQlt
         gSjJjVSjHV0xbztSZUybc1EQN7Pa3i2hKR3Ko=
Received: by 10.101.133.38 with SMTP id k38mr4191085ann.162.1277145660061; 
	Mon, 21 Jun 2010 11:41:00 -0700 (PDT)
Received: by 10.100.141.14 with HTTP; Mon, 21 Jun 2010 11:40:59 -0700 (PDT)
In-Reply-To: <7v631ci6ex.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149433>

On Tue, Jun 22, 2010 at 12:01 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:
>
>> So, here is the message ID
>> 1275399845-13311-1-git-send-email-pavan.sss1991@gmail.com
>
> Do you really mean that one? =A0Jakub had quite long review comments;=
 so did
> Pasky. =A0I had an impression that the following was the last/latest =
version.
>
> =A0 =A0Subject: [PATCHv2] git-instaweb: Add option to reuse previous =
config file
> =A0 =A0Date: Wed, =A02 Jun 2010 03:29:49 +0530
> =A0 =A0Message-ID: <1275429589-30634-1-git-send-email-pavan.sss1991@g=
mail.com>
>
> (FYI, you can visit "http://mid.gmane.org/$that_message_id", click on=
 its
> subject string to see the thread in context).
>
> I see Jakub's Ack to it. =A0Please confirm that one is what you meant=
 and
> I'll apply.
>
> Thanks.
>

Sorry, it is the wrong one

The right one is given below.
http://mid.gmane.org/1275573356-21466-3-git-send-email-pavan.sss1991@gm=
ail.com

It's not acked but it's not commented. So I am guessing nobody has
problem with it.
And everybody is ok with in in my gsoc update.
So, I am guessing you could apply that patch.

Thanks,
Pavan.
