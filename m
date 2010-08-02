From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 2 Aug 2010 17:47:53 -0500
Message-ID: <AANLkTi=QxWzYG0Pv2Cc=rmTB1vECWCdh=W=_8vsRsfnC@mail.gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com> 
	<1280780684-26344-3-git-send-email-avarab@gmail.com> <AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com> 
	<4C5732CE.10906@gmail.com> <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com> 
	<7v39uwk52s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	gitzilla@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:48:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3nu-0007qo-RO
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab0HBWsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:48:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54146 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab0HBWsN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:48:13 -0400
Received: by gxk23 with SMTP id 23so1427480gxk.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nY68ao+qofg1c+XbqWVmD60uFlzNOpe3/pcwG3AS2Wg=;
        b=V1gKKpCqHdkoaxzGhmp9StLI4X8fZVUZPtDjNSmzQ/2e+PMVq7x8rLD7ZzwH4WyL3L
         pkVLVexNQGu38YBiKtXFQNpxW7OJ5w1gtA//nAV3jPFJRthraSs4yqzoJdHUuY5pQ2jQ
         neSDUOlAvfWwkH+Aiu+X0zmrGxOqheMykdDJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=b+6ySAnAXqPjtvX7tJon2EpJrCBIHxVjVOlwe8F/rO7nd+dGFc7ivG8my+sEUTkjPY
         lYS2t/7XftTvw8IBODTSwwn8XsmQZrGhxmW+TeOJB95hK7nioI+QN7hIPgk4dxVKGd/j
         DeZ3LPV994kFGYzmD46U+GNUju9+0cWPatOqI=
Received: by 10.151.63.23 with SMTP id q23mr7873776ybk.133.1280789293173; Mon, 
	02 Aug 2010 15:48:13 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Mon, 2 Aug 2010 15:47:53 -0700 (PDT)
In-Reply-To: <7v39uwk52s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152481>

Heya,

On Mon, Aug 2, 2010 at 17:44, Junio C Hamano <gitster@pobox.com> wrote:
> "shabby" is not a good word to describe a service somebody volunteere=
d to
> maintain for the public good. =C2=A0Be civil, please.

That's why I quoted it, I didn't mean to put =C3=86var's work down and =
I
think he understood what I meant, judging from his reply. On that
note, thanks =C3=86var for reading what I meant, not what I said :).

--=20
Cheers,

Sverre Rabbelier
