From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to git-for-each-ref.txt
Date: Wed, 09 Mar 2011 09:08:16 +0100
Message-ID: <4D773570.4010803@drmicha.warpmail.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com> <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 09:11:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxEUn-0000IS-Lo
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 09:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab1CIILo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 03:11:44 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52296 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752478Ab1CIILn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2011 03:11:43 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 266012052D;
	Wed,  9 Mar 2011 03:11:43 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 09 Mar 2011 03:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ccKuI6EKdpVCZC+3Df3J4XRJy9Q=; b=iPxSF5DLZGwS8peZ4Q+9y9oRNyyofYduIPHZrOYcWWZNLW9wsMmhdfQQLPl+tWKCIynR0K0EMED9K9ubNNu8YEwUGMz1WurDYnRuw8nB+5YhKvzGJVVjFuqhvOj/TrwWUyU8y5vVz+lIhJp5uNAcNZXrmnI53fcMazCDuGZK04A=
X-Sasl-enc: pwpjlXAyOGj1yYs/IGBCLyGcX5s0PvJk4Jkw0tMgkGaX 1299658302
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DE74E4096DD;
	Wed,  9 Mar 2011 03:11:41 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168724>

Alexei Sholik venit, vidit, dixit 08.03.2011 14:16:
> Signed-off-by: Alexei Sholik <alcosholik@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index bffb5d2..ceef54b 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -204,3 +204,15 @@ eval=`git for-each-ref --shell --format="$fmt" \
>  	refs/tags`
>  eval "$eval"
>  ------------
> +
> +Author
> +------
> +Written by Junio C Hamano <gitster@pobox.com>.
> +
> +Documentation
> +--------------
> +Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite

+Evangelisation
---------------
Jeff King <peff@peff.net>

Just kidding!

(Jeff is the 2nd main f-e-r author, but Junio created it.)

Michael ;)
