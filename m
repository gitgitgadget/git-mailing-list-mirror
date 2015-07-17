From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Fri, 17 Jul 2015 18:20:01 +0200
Organization: gmx
Message-ID: <18517252c6c90729777105d4029a1649@www.dscho.org>
References: <1437134351-15392-1-git-send-email-zoe@bytenoise.co.uk>
 <e2ddebd5451a9331e03b24c719f68530@www.dscho.org>
 <9078E9B2-7EB5-4FC9-BE1B-93D67B4D7D2A@bytenoise.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Zo=C3=AB_Blade?= <zoe@bytenoise.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 17 18:20:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG8N3-0006mF-Ew
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 18:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbbGQQUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 12:20:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:51974 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbbGQQUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 12:20:05 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlGoc-1Yij5g37V0-00b4v5; Fri, 17 Jul 2015 18:20:02
 +0200
In-Reply-To: <9078E9B2-7EB5-4FC9-BE1B-93D67B4D7D2A@bytenoise.co.uk>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:ougTBAaj66AJ4ZTb4TaQoRT/VflIyKmXfeJd7t67EKzsX95dILJ
 4okNj5+BFdxmvEwAU2w/CMt74NDRwIPzZ6hW01T/WB1zvJtgUGMolXHdk1pkecMgqfPptbO
 G7VxnFSAPelGPZHdupjz6Vu+4zbxcseTDyRwjtR9r6PZv/eUzktD3drtVAEqv1brOdgl0ki
 hQ0nzD5FCweY2yZHL38ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q1/tCGqa2ow=:5ZSp7kkPobals99mRcds3A
 h2CvZuE/h2TqHpbWQZva3Pm+pg3ToT8yMklBCcTMeQq7FyP0I8WipJB9ZDk45+kgc+nt0Xcpz
 VzmJtgyAwpOLMuGu0mFTqw+xW1l3eH1rnkO88NWM4KzcbvuVtWLTyq5tZMD//ihPQ6Zas1btm
 Vw/5zAP9ef25/B7j3mYAF9xXCsDL1G3NM0GS+iM52Fq8f7i4dDbvPiOWA6XzL3kIomIPX4vP+
 uvr429yShq55HqSaLYYhbHBAP+TxpxBkJrIHR2jFpTUuhJJ6mkP5KjWkxO10uvCE2Oik2XGRY
 gqLc4w26kg605eaxB+Gg6QTLW6EIP0Q37FNSx8I/rA9mgX+DQT6EPQMhgYcUmzzln1vhUYLV0
 1y8otHERLOEK9n4ZSk1/n28S/IQV62s24C+3wlet/ZyArquZPJRgZJXXmk5F9a0cJTxPjJ6II
 aY04KhAlxnU4zhgaC0Y2TqHXMlDAylEah5Km/llCdSqW/gSO2roTS9rbWP3qLHJe3pHZYVuPr
 3Wd0kZWAbPOwSiUSAWyflnZJBU3xr0hW08/KZq7vtAMPgO54RmQShJu+vM6r8JB1h7IeOsR7K
 5AfWGQZnS5xW50rLzPgUensEgGJOlbw49hax0kRKSNBqt3DY0sa+RLpUErGH0Df+VHCUYkxZR
 jv5qA17rfeaanoFlfEu/E97xhzYx+2ABd5TkLZPgs54R6pnROlkdKmvrvHDfTbKTTiTo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274080>

Hi Zo=C3=AB,

On 2015-07-17 16:03, Zo=C3=AB Blade wrote:
> On 17 Jul 2015, at 14:03, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>=20
>> Maybe you want to add a paragraph explaining a bit more about Founta=
in, or at least link to http://fountain.io/?
>>
>> In any case, you will need to sign off on your patch:
>>
>>    https://github.com/git/git/blob/v2.4.6/Documentation/SubmittingPa=
tches#L234-L286
>=20
> Thanks, I'll amend it accordingly.  I originally mentioned the
> Fountain site in my rough draft of the commit message, but then
> removed it again after reading more of the patch submitting
> documentation and not spotting the nuance about when is and isn't a
> good time to include URLs.  No bother, I managed the commit message i=
n
> another repo... :D  I'll bring it back and tidy it up a bit, then sig=
n
> it off.

Thank you!
Dscho
