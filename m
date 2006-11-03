X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 03 Nov 2006 14:03:47 +0000
Message-ID: <454B4C43.2040607@shadowen.org>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <20061103100142.GD16721@diana.vm.bytemark.co.uk> <454B30E4.8000909@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 14:05:28 +0000 (UTC)
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <454B30E4.8000909@shadowen.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30855>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfzev-00048J-6x for gcvg-git@gmane.org; Fri, 03 Nov
 2006 15:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753159AbWKCOE1 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 09:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbWKCOE1
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 09:04:27 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:36624 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1753159AbWKCOE0
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 09:04:26 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gfze6-0007GV-1q; Fri, 03 Nov 2006 14:03:46 +0000
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft wrote:
> Karl Hasselstr=F6m wrote:
>> On 2006-11-03 10:58:59 +0100, Karl Hasselstr=F6m wrote:
>>
>>> I believe all the mails I send with mutt are QP-encoded,
>> I just checked, and that one certainly was.
>=20
> Mime-Version: 1.0
> Content-Type:	text/plain; charset=3Diso-8859-1
> Content-Disposition: inline
> Content-Transfer-Encoding: QUOTED-PRINTABLE
>=20
> It reached me as quoted printable, with =3D20 on your signature intro=
=2E

Heh, well the copy thunderbird wrote directly to my mailbox is also
8bit.  And thinking about it I've seen talk of MTA's not supporting 8bi=
t
xfers between themselves, so thats probabally when it gets switched.

