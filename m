From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: Feature requset: listing of current stash in git gui
Date: Wed, 23 Nov 2011 12:24:03 +0100
Message-ID: <4ECCD7D3.3000608@atlas-elektronik.com>
References: <201111211100.52367.dexen.devries@gmail.com> <4ECA2D8F.4060005@atlas-elektronik.com> <30417194.1411.1321907485839.JavaMail.mobile-sync@ieja14> <-8099236111493298698@unknownmsgid>	<4ECBBD72.40101@atlas-elektronik.com> <CAJDDKr78CV+eDrfSg4Tqp5W2N4MDTaqAcxiB5JrNpUyEn5vqAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dexen deVries <dexen.devries@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 12:24:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTAvz-0005IX-HE
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 12:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab1KWLYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 06:24:06 -0500
Received: from mail96.atlas.de ([194.156.172.86]:26657 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985Ab1KWLYF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 06:24:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 29AE610080;
	Wed, 23 Nov 2011 12:24:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id FgkfHVTn3BRt; Wed, 23 Nov 2011 12:24:02 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed, 23 Nov 2011 12:24:02 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 754B72718F;
	Wed, 23 Nov 2011 12:24:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CAJDDKr78CV+eDrfSg4Tqp5W2N4MDTaqAcxiB5JrNpUyEn5vqAQ@mail.gmail.com>
X-Enigmail-Version: 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185838>

Am 23.11.2011 12:20, schrieb David Aguilar:
> On Tue, Nov 22, 2011 at 7:19 AM, Stefan N=C3=A4we
> <stefan.naewe@atlas-elektronik.com> wrote:
>> Am 22.11.2011 11:24, schrieb David Aguilar:
>>>
>>> git-cola has this feature.
>>>>
>>>
>>>    http://git-cola.github.com/
>>
>> Yeah, right. I totally forgot about git cola.
>>
>> But I guess there's no way of starting only the stash view like the =
'DAG'
>> view, is there ?
>=20
> That's a good idea.
>=20
> https://github.com/git-cola/git-cola/commit/0b1bf59c0b4a455cc8a9149dc=
fcafb5bed3a19ab
>=20
>     git cola stash
>     git cola classic
>     (and a few others)
>     ...

Perfetto!

Stefan
--=20
----------------------------------------------------------------
/dev/random says: Thesaurus: ancient reptile with an excellent vocabula=
ry.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
