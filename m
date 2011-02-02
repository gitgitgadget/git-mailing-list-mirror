From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: moving to a git-backed wiki
Date: Wed, 2 Feb 2011 12:53:51 +0200
Message-ID: <AANLkTi=07yifUAQYqabA8Dv1qmBTe=50+BDN-b0YZ1zb@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
	<7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
	<20110131225529.GC14419@sigill.intra.peff.net>
	<AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
	<20110201201144.GA16003@sigill.intra.peff.net>
	<AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
	<4D488DCD.3080305@eaglescrag.net>
	<4D4929F4.3020805@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Vincent Hanquez <tab@snarc.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 11:54:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkaLZ-0002qL-7w
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 11:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab1BBKxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 05:53:54 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53070 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab1BBKxw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 05:53:52 -0500
Received: by fxm20 with SMTP id 20so7870069fxm.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 02:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WL6G3dprWTbY3REoLt3h/ZFUPBH84P/NSrnJ5yOZ7c4=;
        b=ec//wXZ5VZfFOG96OK9NVyHkRYm2as3mvVxHmmuyD58c4er5lzVNhHYa7aAs6BojgE
         RKMt8MtA/7cJKCVl62omBOMMuTUEoVqZzxtwIuRpm8VM+1dkWHnTFOKKGvrAEoF9WYCh
         LsNvT33Sj5XT69cxde+Vf8ruZHHJ8L7HmI8z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B/ogWU+Zbi8B7UqAmJsxolalAXSjHSb/syhxVM3Li/lVrEanSPkgLvzYjLIXwx0tnH
         DLkH7qi+2d4s2OQGbOjPhJ9lJCtnpdPpCGVJ0H5FjAYsfLOgaIKAmMj+qVtRccfn4PVs
         dhGmTGps2/sun4ZWHsh6pm8fMZ0aDYbV+Zuss=
Received: by 10.223.103.5 with SMTP id i5mr8711325fao.38.1296644031377; Wed,
 02 Feb 2011 02:53:51 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Wed, 2 Feb 2011 02:53:51 -0800 (PST)
In-Reply-To: <4D4929F4.3020805@snarc.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165902>

On Wed, Feb 2, 2011 at 11:55 AM, Vincent Hanquez <tab@snarc.org> wrote:
> =C2=A0On 01/02/11 22:48, J.H. wrote:
>>
>> The wiki will almost universally have a "central site" no matter wha=
t
>> the backend. =C2=A0Personally I see little advantage to having a git=
 backed
>> wiki myself.
>
> with git based wiki, you can clone the whole wiki on your local machi=
ne, and
> read/edit/commit on it locally using standard editor tool (i.e. $EDIT=
OR).
> and the history/revision/diff is completely built-in.

But there's no git based wiki (or any other wiki) that has even a
fraction of the features that MediaWiki has, or IMO a markup format
similarly sane.

--=20
=46elipe Contreras
