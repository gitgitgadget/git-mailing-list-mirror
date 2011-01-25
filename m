From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Tue, 25 Jan 2011 08:57:03 +0100
Message-ID: <AANLkTi=A=yD4Oe-meB=ZMFe_Wm8om-hmA_MOU8vyyBNR@mail.gmail.com>
References: <cover.1295295897.git.raa.lkml@gmail.com>
	<1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
	<20110117210828.GC27029@blimp.localdomain>
	<AANLkTinZCegWW-6uQ++uO9fGQ4SQ34=W4TJXW6ii5jXD@mail.gmail.com>
	<87wrltnakc.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Jan 25 08:57:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phdm5-0004RP-HC
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 08:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab1AYH5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 02:57:07 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59839 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab1AYH5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 02:57:06 -0500
Received: by bwz15 with SMTP id 15so85919bwz.19
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 23:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zq3sdMnO+PLY5y2EuO3UAXZ/QYBgpKD6uR54vyH0+FU=;
        b=iV2+OytFcdI4qXxG/Rfqg2mj4AcwBE0tZ9YNzP243GYsAYrCJOVaru+3FZDQ1nJ8As
         H4mQ4C6GIsc4ndo+9i8MVQ7G2lLZh0p+hAg5+yr2/TYCybLYiL+4+cOAo6tYXYxkh9eg
         OpjnfH1BMoFYFJP7FDeo3OaBEJ9Om4DijISbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zha9kPUfBaTtjKCioaGJnq4OgLmXvKglrwS7ErC/wVKN9kBIfUVK8/grvWyiIf3DZl
         mWg7r4qOiuoLLgJ9MnxsaDOnN4i4h2XF0D7PhO93a1tQAirU9bn1LytfXZH9JHwshyvD
         hFUoGnJ+zpuI8ALvJ3qETvDOYHNKX6rVGEqDc=
Received: by 10.204.80.161 with SMTP id t33mr4746532bkk.121.1295942223911;
 Mon, 24 Jan 2011 23:57:03 -0800 (PST)
Received: by 10.204.102.14 with HTTP; Mon, 24 Jan 2011 23:57:03 -0800 (PST)
In-Reply-To: <87wrltnakc.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165471>

On Tue, Jan 25, 2011 at 00:31, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>>2011/1/17 Alex Riesen <raa.lkml@gmail.com>:
>>> =C2=A0po/ru.po | =C2=A0 24 ++++++++++++------------
>>> =C2=A01 files changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/po/ru.po b/po/ru.po
>>> index c15bdfa..304bb3a 100644
>>
>>BTW, does anyone know what happens to git-gui development?
>>In particular, the i18n patches. The old way of pushing
>>to a mob branch seems to stopped working, and anyway, the
>>branch is very out of date.
>>
>>Is git gui development stalled? Should I perhaps send the
>>i18n pull request directly to Junio?
>>
>
> If you post here they'll get picked up eventually.
> If you want to use the mob branch, we can use that too but you would
> need to post here and to me to notify everyone.

What's with git-gui-i18n/mob branch being out-of-date? Actually,
it seems to be abandoned, because it does have quite a bit of
changes in it which are not in git-gui/master: spanish, bulgarian,
portugese, romanian, chinese, italian, japan and greek:

  $ git cherry -v git-gui-i18n/master git-gui-i18n/mob
  - 0896a7856335cc934328e02b84e1e41b9db2632d Updated Hungarian
translation (e5fba18)
  + c6fb29db5a50df150280b641d3c2a6703589b529 Fixed usage of positional
parameters in it.po and ja.po
  + a1fdd910cf11837135f8b007dbb1380131f8d107 Started Romanian Translati=
on
  + 2f27eb24bf1dfdbb14dbc44698cb07ed294a10cf Start Spanish translation
  + 4616c11423484f40361466e0f2470d6c4a29e692 More strings for Spanish
translation
  + e51f330c4c94795cb7cfd151df2f2a222bde0d66 Yet more strings translate=
d...
  + 0947a8e1d71ff03fbc2838f4742de8aa6c971083 Translated a few more stri=
ngs
  - 71438168c673dd644b442a4c3f863456ddf4b13b Update french translation.
  + bb88a426e49b73c6e7f9b0c8c3be6dc1946252a7 More translated strings
for Spanish. Close to being there...
  + 1cf3364c33c57f83b214e51a3ee260334ddc7e56 Fixed usage of positional
parameters in ja.po
  + 3f4263f049b76118ce8f8f35aacc99dc2f958a82 A few more strings
  + 31da610cb074364aa8d6e32c4cf2a3b5c6d16b51 A Bulgarian translation
has been added.
  + ad8d6a97f364f4ee3082258aeddb0488652b81d2 git-gui: Update
simplified Chinese translation to POT-2008-08-02
  + 6227f5ee3c74078eec37790111242ac3856759da git-gui: Add traditional
Chinese translation
  + de6afb81c44b44722affd8f2f6aa26fece24c401 Started Portuguese transla=
tion.
  + 78ae667f948ed29dca3f7abc3ae67996a56fabf7 Cleaned header of
Portuguese translation and corrects translation of "Commit@@verb".
  + c71abd9b3de78db783e8a7af92fb75bdd57bf2a9 Clean messed up header fro=
m KBabel
  + 7b89dc573b03e26ef0b620b5f73aaf116f0eaef9 Added Greek translation & =
glossary
