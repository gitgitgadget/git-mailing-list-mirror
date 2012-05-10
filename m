From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH 10/10] l10n: de.po: translate one new message
Date: Thu, 10 May 2012 08:34:56 +0200
Message-ID: <CAN0XMO+Kzen9RWr5wvbTeb5uTM9YeFgd_TobAZPso-y5NkHHbg@mail.gmail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
	<1336498425-17890-11-git-send-email-ralf.thielow@googlemail.com>
	<CANYiYbGn1Wq22ZHQLoPLouX8UT0W3_+yP4ADZRzJ+B+P_EJaBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	git@vger.kernel.org
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 08:35:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMyM-0006UU-BA
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab2EJGe7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 02:34:59 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41224 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab2EJGe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 02:34:57 -0400
Received: by gglu4 with SMTP id u4so703245ggl.19
        for <git@vger.kernel.org>; Wed, 09 May 2012 23:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=60BTQE1A0pq02qDwC8Ga5h174uQnhdXq7HzgL1+J74E=;
        b=Y7CJ94NYq4vJiwNrNPxcYE2YnxppAR7SAEsfdDwAQF5P7b5lS0mR0FZGldJIVAZ4p4
         PIredjhQbdWoj7DZa/PNpmrLNnTGB93TXimv65K2vYLGOlIqS1g1t5SfDtfkDxLjhol9
         zu5UCibBSc8n+hhw8xTwddqtemOPuDthoWEiZAIxLq8nuxbhwunSfVY1XoLjqYMEZeMj
         zwqfD+QwC7HdepEHhU0L2vrr8vb1hcClKNIDc5fQCmn1dKbe0gRNmi5sbLze8x4w3ZG0
         6N+GSdA1IyUyqoH0E7tzGDMHKVsKTU1iSKPiDA/QbDnzWE+Ic/vPFqT8LhOLOwB7zNHb
         46NA==
Received: by 10.236.75.232 with SMTP id z68mr3885866yhd.6.1336631696366; Wed,
 09 May 2012 23:34:56 -0700 (PDT)
Received: by 10.146.218.6 with HTTP; Wed, 9 May 2012 23:34:56 -0700 (PDT)
In-Reply-To: <CANYiYbGn1Wq22ZHQLoPLouX8UT0W3_+yP4ADZRzJ+B+P_EJaBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197547>

On Thu, May 10, 2012 at 1:17 AM, Jiang Xin <worldhello.net@gmail.com> w=
rote:
> 2012/5/9 Ralf Thielow <ralf.thielow@googlemail.com>:
>> -#: builtin/fetch.c:298
>> +#: builtin/fetch.c:305
>> =C2=A0msgid "[new tag]"
>> =C2=A0msgstr "[neue Markierung]"
>>
>> -#: builtin/fetch.c:302
>> +#: builtin/fetch.c:308
>> =C2=A0msgid "[new branch]"
>> =C2=A0msgstr "[neuer Zweig]"
>
> A silly question, why not "[neue Zweig]"?
>

Because the word "Zweig" is masculine. The words "Referenz" or "Markier=
ung"
are feminin.

Ralf
