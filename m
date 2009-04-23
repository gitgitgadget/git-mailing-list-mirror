From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/8] config.txt: remove pointer to SubmittingPatches
Date: Thu, 23 Apr 2009 14:05:12 +0200
Message-ID: <49F05978.30009@drmicha.warpmail.net>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com> <1240479482-31366-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:07:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwxhg-0008Ji-7V
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 14:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbZDWMFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 08:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbZDWMFV
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 08:05:21 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33470 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752660AbZDWMFV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 08:05:21 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 4506431587F;
	Thu, 23 Apr 2009 08:05:20 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 23 Apr 2009 08:05:20 -0400
X-Sasl-enc: ZnW3JEMqfKoMm3Inw3YUn8zO0jlk53OQvD/i4r6CDywB 1240488319
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8C6312B0F8;
	Thu, 23 Apr 2009 08:05:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1240479482-31366-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117334>

Stephen Boyd venit, vidit, dixit 23.04.2009 11:37:
> SubmittingPatches exists in the git source documentation for developers
> of git and is not included in the man/html page distributions.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>  Documentation/config.txt |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 35056e1..fb7adfa 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -743,7 +743,6 @@ format.signoff::
>      format-patch by default. *Note:* Adding the Signed-off-by: line to a
>      patch should be a conscious act and means that you certify you have
>      the rights to submit this work under the same open source license.
> -    Please see the 'SubmittingPatches' document for further discussion.

Shouldn't we point to the source then? We're not talking about links
here, only references in the sense of referring to further reading.

>  
>  gc.aggressiveWindow::
>  	The window size parameter used in the delta compression
