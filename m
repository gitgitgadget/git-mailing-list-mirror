From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Thu, 27 Jan 2011 11:47:27 +0000
Message-ID: <87fwseo9f4.fsf@fox.patthoyts.tk>
References: <cover.1295295897.git.raa.lkml@gmail.com>
	<1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
	<20110117210828.GC27029@blimp.localdomain>
	<AANLkTinZCegWW-6uQ++uO9fGQ4SQ34=W4TJXW6ii5jXD@mail.gmail.com>
	<87wrltnakc.fsf@fox.patthoyts.tk>
	<AANLkTi=A=yD4Oe-meB=ZMFe_Wm8om-hmA_MOU8vyyBNR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 12:47:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiQKN-0004i7-G5
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 12:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab1A0Lrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jan 2011 06:47:47 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:40945 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754108Ab1A0Lrq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 06:47:46 -0500
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2011 06:47:45 EST
Received: from [172.23.170.141] (helo=anti-virus02-08)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PiQKF-0003bX-BX; Thu, 27 Jan 2011 11:47:43 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PiQK0-0001WT-PI; Thu, 27 Jan 2011 11:47:28 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id BEB8130254; Thu, 27 Jan 2011 11:47:28 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTi=A=yD4Oe-meB=ZMFe_Wm8om-hmA_MOU8vyyBNR@mail.gmail.com>
	(Alex Riesen's message of "Tue, 25 Jan 2011 08:57:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165575>

Alex Riesen <raa.lkml@gmail.com> writes:

>On Tue, Jan 25, 2011 at 00:31, Pat Thoyts
><patthoyts@users.sourceforge.net> wrote:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>>>2011/1/17 Alex Riesen <raa.lkml@gmail.com>:
>>>> =A0po/ru.po | =A0 24 ++++++++++++------------
>>>> =A01 files changed, 12 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/po/ru.po b/po/ru.po
>>>> index c15bdfa..304bb3a 100644
>>>
>>>BTW, does anyone know what happens to git-gui development?
>>>In particular, the i18n patches. The old way of pushing
>>>to a mob branch seems to stopped working, and anyway, the
>>>branch is very out of date.
>>>
>>>Is git gui development stalled? Should I perhaps send the
>>>i18n pull request directly to Junio?
>>>
>>
>> If you post here they'll get picked up eventually.
>> If you want to use the mob branch, we can use that too but you would
>> need to post here and to me to notify everyone.
>
>What's with git-gui-i18n/mob branch being out-of-date? Actually,
>it seems to be abandoned, because it does have quite a bit of
>changes in it which are not in git-gui/master: spanish, bulgarian,
>portugese, romanian, chinese, italian, japan and greek:
>
>  $ git cherry -v git-gui-i18n/master git-gui-i18n/mob
>  - 0896a7856335cc934328e02b84e1e41b9db2632d Updated Hungarian
>translation (e5fba18)
>  + c6fb29db5a50df150280b641d3c2a6703589b529 Fixed usage of positional
>parameters in it.po and ja.po
>  + a1fdd910cf11837135f8b007dbb1380131f8d107 Started Romanian Translat=
ion
>  + 2f27eb24bf1dfdbb14dbc44698cb07ed294a10cf Start Spanish translation
>  + 4616c11423484f40361466e0f2470d6c4a29e692 More strings for Spanish
>translation
>  + e51f330c4c94795cb7cfd151df2f2a222bde0d66 Yet more strings translat=
ed...
>  + 0947a8e1d71ff03fbc2838f4742de8aa6c971083 Translated a few more str=
ings
>  - 71438168c673dd644b442a4c3f863456ddf4b13b Update french translation=
=2E
>  + bb88a426e49b73c6e7f9b0c8c3be6dc1946252a7 More translated strings
>for Spanish. Close to being there...
>  + 1cf3364c33c57f83b214e51a3ee260334ddc7e56 Fixed usage of positional
>parameters in ja.po
>  + 3f4263f049b76118ce8f8f35aacc99dc2f958a82 A few more strings
>  + 31da610cb074364aa8d6e32c4cf2a3b5c6d16b51 A Bulgarian translation
>has been added.
>  + ad8d6a97f364f4ee3082258aeddb0488652b81d2 git-gui: Update
>simplified Chinese translation to POT-2008-08-02
>  + 6227f5ee3c74078eec37790111242ac3856759da git-gui: Add traditional
>Chinese translation
>  + de6afb81c44b44722affd8f2f6aa26fece24c401 Started Portuguese transl=
ation.
>  + 78ae667f948ed29dca3f7abc3ae67996a56fabf7 Cleaned header of
>Portuguese translation and corrects translation of "Commit@@verb".
>  + c71abd9b3de78db783e8a7af92fb75bdd57bf2a9 Clean messed up header fr=
om KBabel
>  + 7b89dc573b03e26ef0b620b5f73aaf116f0eaef9 Added Greek translation &=
 glossary
>

The git-gui/git-gui-i18n.git repository is a fork that was created to d=
o
the initial internationalization of git-gui I believe. It predates my
involvement with this project so I could be wrong.

We don't provide a mob branch but you could create your own fork on
repo.or.cz if you intend to do much development and then post merge
requests to this group and myself.

I think I'd prefer to see forks than use a mob branch. Or receive
patches or course.

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
