From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: How to see 'assume-unchanged' information
Date: Tue, 20 Sep 2011 14:06:51 +0200
Message-ID: <4E7881DB.1070207@atlas-elektronik.com>
References: <4E787AD3.2000208@atlas-elektronik.com> <CACsJy8B1jPmkLB8xq86Ji52G=zGn+3K1_meL5K2T-spDpagL6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 14:07:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5z6I-0006TB-SH
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 14:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab1ITMGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 08:06:54 -0400
Received: from mail96.atlas.de ([194.156.172.86]:24430 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967Ab1ITMGx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 08:06:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 228041005C;
	Tue, 20 Sep 2011 14:06:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id m6ZGiLcSvcQL; Tue, 20 Sep 2011 14:06:52 +0200 (CEST)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue, 20 Sep 2011 14:06:52 +0200 (CEST)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 1CBD42718B;
	Tue, 20 Sep 2011 14:06:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <CACsJy8B1jPmkLB8xq86Ji52G=zGn+3K1_meL5K2T-spDpagL6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181759>

Am 20.09.2011 14:02, schrieb Nguyen Thai Ngoc Duy:
> On Tue, Sep 20, 2011 at 9:36 PM, Stefan N=C3=A4we
> <stefan.naewe@atlas-elektronik.com> wrote:
>> Hi there.
>>
>> Is it somehow possible to see which files have the 'assume unchanged=
'
>> bit set ?
>=20
> git ls-files -v

Oh..how obvious...

Someone should update the manpage of 'update-index' to refer to 'ls-fil=
es'...
Maybe I find some time for that.

Thx,
  Stefan
--=20
----------------------------------------------------------------
/dev/random says: Send $20 and I will double your IQ or no money back.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
