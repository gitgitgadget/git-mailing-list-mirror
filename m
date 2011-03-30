From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Translation inclusion criteria
Date: Wed, 30 Mar 2011 14:08:58 +0100
Message-ID: <87tyekpxg5.fsf@fox.patthoyts.tk>
References: <4D889CC9.4060603@gmail.com>
	<1301417951.13114.7.camel@drew-northup.unet.maine.edu>
	<7vhbalrbwi.fsf@alter.siamese.dyndns.org> <4D9231F6.80205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 15:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4v93-0003TZ-VC
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 15:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab1C3NJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 09:09:03 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:47590 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754217Ab1C3NJB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 09:09:01 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20110330130859.KXOT18231.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Wed, 30 Mar 2011 14:08:59 +0100
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Q4v8t-0006qY-Jq; Wed, 30 Mar 2011 14:08:59 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 149B0234BE; Wed, 30 Mar 2011 14:08:59 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <4D9231F6.80205@gmail.com> (Rodrigo Rosenfeld Rosas's message of
	"Tue, 29 Mar 2011 16:24:38 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=QCTNZaaPMWkA:10 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8 a=Rf460ibiAAAA:8 a=XSml1LXEuemWVDRiQxUA:9 a=vYwQ58lgX8J6NeRvFa8A:7 a=6nj2ttJJq3PlrN7FOuzDkU2CLIYA:4 a=wPNLvfGTeEIA:10 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170383>

Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com> writes:

> Em 29-03-2011 15:59, Junio C Hamano escreveu:
>> Drew Northup<drew.northup@maine.edu>  writes:
>>
>>> On Tue, 2011-03-22 at 09:57 -0300, Rodrigo Rosenfeld Rosas wrote:
>>>> Hi, I've followed the instructions in git-gui/po/README in 2008 bu=
t
>>>> pt.po was never included in master. Now I've just updated it.
>>>>
>>>> Is there anything else I should do for it being merged to master? =
What
>>>> is the criteria for including new translations?
>>> ...
>>> Rodrigo,
>>> Internationalization of Git is very much an ongoing process. I susp=
ect
>>> that has something to do with the uptake of your contribution. =C6v=
ar may
>>> have more information.
>> All the git-gui changes come through Pat Thoyts these days; =C6var h=
as
>> nothing to with git-gui i18n/l10n (except perhaps as a translator to=
 his
>> own language, but I don't see his name in the shortlog).
>>
>> Perhaps the submission was sent with wrong Cc:; I don't pay attentio=
n to
>> git-gui and gitk l10n patches myself.
>
>Sorry, I think I'm missing something. From the mentioned README, it
>seems we're supposed to push our changes to the mob branch of
>mob@repo.or.cz:/srv/git/git-gui/git-gui-i18n.git/, which has write
>access enabled for everyone.
>
>That's what I've done. I couldn't find any mention in the README about
>having to send some mail after that.
>
>I'll wait for instructions from Pat Thoyts to understand better what
>should be my next step...
>
>Thanks,
>
>Rodrigo.

It's best to just send a patch to me and this list based against one
of the current branches (master/maint/pu). The i18n fork was done for
the original work adding i18n to git-gui and hasn't been kept up to dat=
e
since 2008.

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
