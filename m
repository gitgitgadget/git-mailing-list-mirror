From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 14:03:28 -0400
Message-ID: <078307FA-6A50-4615-B4C8-4DB2CF3E301F@gernhardtsoftware.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com> <AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com> <AANLkTim8aPoOkzzf4c0JHbBDVa4zJY2xM3v9fXQ-px=V@mail.gmail.com> <AANLkTimNGZom6FfKivg=QNmovz=xf656XHbXCmsjfrxD@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Tait <git.git@t41t.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Sep 24 20:03:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzCcc-0003ff-As
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 20:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203Ab0IXSDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 14:03:36 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:50308 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab0IXSDe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 14:03:34 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 5F5691FFC6B6; Fri, 24 Sep 2010 18:03:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 1C09E1FFC544;
	Fri, 24 Sep 2010 18:03:25 +0000 (UTC)
In-Reply-To: <AANLkTimNGZom6FfKivg=QNmovz=xf656XHbXCmsjfrxD@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157027>


On Sep 24, 2010, at 10:08 AM, Tor Arntsen wrote:

> On Fri, Sep 24, 2010 at 15:32, =C6var Arnfj=F6r=F0 Bjarmason <avarab@=
gmail.com> wrote:
>> On Fri, Sep 24, 2010 at 13:08, Tor Arntsen <tor@spacetec.no> wrote:
>>> 5.8 as minimum is probably for the best. It's not that just you can
>>> compile a newer version (5.8), more importantly, Perl 5.8 is availa=
ble
>>> as a package from those semi-official 3party repositories for most
>>> systems (at least the *nix systems I have access to)
>>=20
>> Do those repositories also have 5.10 and 5.12?
>=20
> Anything later than 5.8 seems to very unusual except for Linux (and
> presumably *bsd).

Based on www.opensource.apple.com, OS X started having 5.8 in OS X 10.3=
=2E0.  (And has only had 5.10 starting with 10.6.)  I don't know if mac=
ports or fink still support older OS X versions, so likely a 5.8 requir=
ement would make anyone OS X older than 10.3 build perl-5.8 from source=
=2E

Just FYI,
~~ Brian