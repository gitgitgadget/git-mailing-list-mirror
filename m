From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation/merge subtree How-To: fix typo
Date: Wed, 09 Feb 2011 16:58:02 +0100
Message-ID: <4D52B98A.2060408@drmicha.warpmail.net>
References: <1297242283-11532-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Feb 09 17:01:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnCTh-0002ci-Op
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 17:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396Ab1BIQBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 11:01:07 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40869 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752105Ab1BIQBG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 11:01:06 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8F63221A91;
	Wed,  9 Feb 2011 11:01:05 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 09 Feb 2011 11:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6awgV5nAOEdyXzZme3qOH+dRWdk=; b=SrjwMxN6BwoffOwM+3K1kt6kJWgjNdUJS/pD0ne1dD7SwNxBeoRO8B7g3baHB4bkzs/5zYDLHT7V3wgmv3/8J4TJEXWRkgrtcS0c0HNHSdvPc821N9sJ0Q9WesaGX1qI8+Ey6RS3IQzfdBbBlNqDOCwzqjniTlZMSLNy5Y7i4Cg=
X-Sasl-enc: 73P/0foGfkDILJlFlQAeloL3o8SEqQQiqrKwvSQ8dEx8 1297267265
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1F0DD44C9C7;
	Wed,  9 Feb 2011 11:01:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <1297242283-11532-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166426>

Uwe Kleine-K=C3=B6nig venit, vidit, dixit 09.02.2011 10:04:
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/howto/using-merge-subtree.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/howto/using-merge-subtree.txt b/Documentat=
ion/howto/using-merge-subtree.txt
> index 0953a50..2933056 100644
> --- a/Documentation/howto/using-merge-subtree.txt
> +++ b/Documentation/howto/using-merge-subtree.txt
> @@ -71,5 +71,5 @@ Additional tips
>    relevant parts of your tree.
> =20
>  - Please note that if the other project merges from you, then it wil=
l
> -  connects its history to yours, which can be something they don't w=
ant
> +  connect its history to yours, which can be something they don't wa=
nt
>    to.

On that occasion you may scrap the final "to". It's either "they don't
want" (which I suggest) or "they don't want to do".

Michael
