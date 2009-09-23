From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2009, #05; Wed, 23)
Date: Wed, 23 Sep 2009 10:01:10 +0200
Message-ID: <fabb9a1e0909230101x3a5415aehf8b0c3a13ca28d14@mail.gmail.com>
References: <7vhbuui1ys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 10:02:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqMnB-0002Le-H5
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 10:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbZIWIB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2009 04:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbZIWIB2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 04:01:28 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:6993 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbZIWIB1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2009 04:01:27 -0400
Received: by ey-out-2122.google.com with SMTP id d26so108298eyd.19
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QmMR8yAJq/hLljBXklUBt4G5kWiNjtTPcqtMOyjbAuY=;
        b=wwxaAKxF7xWDQ3shsrWvwLhZGu7tDN7rPceVfU2dr4KSki/wtxX80lzCq2jdvghmiH
         duBx2XocY1psQLIks1N/Zh5yrChXmQwv0UhQr5sljCvFus/mIR2qvQxX3DirwlV/2pVp
         UTGEJi8/Ibmh9krBvNZCzaMrRvGJXwFGKRD4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pssk1qpsNNew77fbcNb6PLm1Pm+ZLcLiFD9FkjtXlYMEm8ySh7kZ1ca2OqMlsV9WSJ
         f1nXUGmJZdak+nBwRDmdLtz6mQY9GzI1fonBmaA2mB4GW6U21+pu0as179ZQy6ZolpQq
         VwUx8evpWMzHTckMZdoECsjqR3zeun3Rio2mQ=
Received: by 10.216.90.67 with SMTP id d45mr423978wef.42.1253692890176; Wed, 
	23 Sep 2009 01:01:30 -0700 (PDT)
In-Reply-To: <7vhbuui1ys.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128972>

Heya,

On Wed, Sep 23, 2009 at 08:56, Junio C Hamano <gitster@pobox.com> wrote=
:
> * sr/gfi-options (2009-09-06) 6 commits
> =A0(merged to 'next' on 2009-09-07 at 5f6b0ff)
> =A0+ fast-import: test the new option command
> =A0+ fast-import: add option command
> =A0+ fast-import: test the new feature command
> =A0+ fast-import: add feature command
> =A0+ fast-import: put marks reading in it's own function
> =A0+ fast-import: put option parsing code in separate functions
> =A0(this branch is used by jh/notes.)
>
> Ping?

Ping indeed, Shawn? Blocking on a reply to whether I should drop the
option part and make location of the marks file a feature or not in
general, and $128290 in specific [0].

[0] http://article.gmane.org/gmane.comp.version-control.git/128290

--=20
Cheers,

Sverre Rabbelier
