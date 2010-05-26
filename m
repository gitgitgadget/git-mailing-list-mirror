From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Fix typo in GMail section
Date: Wed, 26 May 2010 15:42:59 +0200
Message-ID: <4BFD2563.4020801@drmicha.warpmail.net>
References: <AANLkTinWWEMB3VjX0HOnulzJG4KEddqdSQ9ls724_wO5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 15:43:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHGtE-0007EU-Ka
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 15:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030Ab0EZNnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 09:43:15 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52102 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754637Ab0EZNnP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 09:43:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8BA5EF6644;
	Wed, 26 May 2010 09:43:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 26 May 2010 09:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nUp4LZ//AluBh9W/UDCleqSRtMw=; b=rteRyyjV7GygXoA8nrMaQailxGuDOSmss63M6oY/go4rHFpJoegpI56BZ8BzwHWArsTJxef8pXqp9ydQl8buyV+hR83ZlqfauVgMVU6lEo0GAx5guRDxreone6WScZzE+vFMordgaY09CGVt24EVutIiLCemsIcQAqKtm02PMAA=
X-Sasl-enc: hw2GdB+lcdbA10JmeLomIa5+MUybTdtVMRDb7e3eOZAv 1274881394
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C83DD5B2AB;
	Wed, 26 May 2010 09:43:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTinWWEMB3VjX0HOnulzJG4KEddqdSQ9ls724_wO5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147797>

Tim Henigan venit, vidit, dixit 26.05.2010 14:36:
> Commit e498257d introduced a typo while improving the GMail section
> of SubmittingPatches.
> 
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---

Thanks and sorry, respectively.

Acked-by: Michael J Gruber <git@drmicha.warpmail.net>

> This patch was based on 'maint'.
> 
>  Documentation/SubmittingPatches |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 22e3808..84248da 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -520,7 +520,7 @@ Gmail
> 
>  GMail does not appear to have any way to turn off line wrapping in the web
>  interface, so this will mangle any emails that you send.  You can however
> -use "git send e-mail" and send your patches through the GMail SMTP server, or
> +use "git send-email" and send your patches through the GMail SMTP server, or
>  use any IMAP email client to connect to the google IMAP server and forward
>  the emails through that.
> 
