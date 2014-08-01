From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: fix typo
Date: Fri, 1 Aug 2014 18:34:37 +0200
Message-ID: <CAN0XMOJhiRUMtTxn1irJnUTi+WwaNS9taqogw490XorqKwt0HQ@mail.gmail.com>
References: <1402503455-20503-1-git-send-email-ralf.thielow@gmail.com>
	<alpine.DEB.2.02.1408011535110.18761@hahepc.vhs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Hartmut Henkel <henkel@vh-s.de>
X-From: git-owner@vger.kernel.org Fri Aug 01 18:34:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDFn2-00066Z-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 18:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbaHAQel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 12:34:41 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:42320 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaHAQek convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 12:34:40 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so4635899wes.39
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0H/5eTKce3SF1+DC09BDrAkW+bGxRzBsXSKia2wA5yM=;
        b=CQtLqyPTXXdobAxh6AnmqaZkZlaphX83oCA4INMJ7k/1giL8I4rHjR3cLttaGvFhht
         FB1aHS/0P9una24BQtMKIwLksgInX52mapk2O3FhCgdHXJVwy7eJBcfDN5V2SFVv8/o0
         bg3RTWAqE7u216VxP11UJhK4u+kpyvD+gG+ejXCmhpHnTdQ1O7RjPHEexnPJO70sXeYT
         0ILkdpQl9tefHkNfNFcyg1DU78E3zYTWdMiVKCSFZTvQqxN5kWJTgJK9bn840QVDskXJ
         97Pvue5R1NOYtCC6O/pQXKfmksspjWJqVYBG2U2kF7NKMigmnAfD3eBM5O2nYOmhEKeJ
         54Gw==
X-Received: by 10.180.19.227 with SMTP id i3mr8398994wie.45.1406910877947;
 Fri, 01 Aug 2014 09:34:37 -0700 (PDT)
Received: by 10.194.203.199 with HTTP; Fri, 1 Aug 2014 09:34:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1408011535110.18761@hahepc.vhs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254630>

Hi Hartmut,

2014-08-01 15:37 GMT+02:00 Hartmut Henkel <henkel@vh-s.de>:
> Dear Ralf,
>
> thanks a lot for signing off the tiny patch below. Yet somehow it did=
n't
> make it into git version 2.1.0.rc0.52.gaa544bf.
>

my plan is to make this patch be part of the translations
for the 2.1.0 release. I'll be sending a pull request
(containing this patch) to the l10n coordinator when the
other translations for this release are done.

Ralf

> Regards, Hartmut
>
>
> On Wed, 11 Jun 2014, Ralf Thielow wrote:
>
>> Reported-by: Hartmut Henkel
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>>  po/de.po | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/po/de.po b/po/de.po
>> index b777ef4..88d10ed 100644
>> --- a/po/de.po
>> +++ b/po/de.po
>> @@ -10551,13 +10551,13 @@ msgstr "Bitte committen Sie die =C3=84nder=
ungen oder benutzen Sie \"stash\"."
>>  #: git-rebase.sh:577
>>  #, sh-format
>>  msgid "Current branch $branch_name is up to date."
>> -msgstr "Aktueller Branch $branch_name ist auf dem neusten Stand."
>> +msgstr "Aktueller Branch $branch_name ist auf dem neuesten Stand."
>>
>>  #: git-rebase.sh:581
>>  #, sh-format
>>  msgid "Current branch $branch_name is up to date, rebase forced."
>>  msgstr ""
>> -"Aktueller Branch $branch_name ist auf dem neusten Stand, Rebase er=
zwungen."
>> +"Aktueller Branch $branch_name ist auf dem neuesten Stand, Rebase e=
rzwungen."
>>
>>  #: git-rebase.sh:592
>>  #, sh-format
>> --
>> 2.0.0.415.g8cd8cf8
