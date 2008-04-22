From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Spelling fixes in the gitweb documentation
Date: Tue, 22 Apr 2008 00:48:21 -0700
Message-ID: <7vod822uuy.fsf@gitster.siamese.dyndns.org>
References: <1208432752-24620-1-git-send-email-rgarciasuarez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:49:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoDFf-0006Km-Aa
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 09:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482AbYDVHse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 03:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbYDVHsd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 03:48:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbYDVHsd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 03:48:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EE1391F43;
	Tue, 22 Apr 2008 03:48:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4D62F1F42; Tue, 22 Apr 2008 03:48:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80076>

Rafael Garcia-Suarez <rgarciasuarez@gmail.com> writes:

> Mostly spelling and grammar nits.
>
> Signed-off-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>

Thanks.

> -  using GITWEB_CONFIG environmental variable. If this file does not
> +  using the GITWEB_CONFIG environment variable. If this file does not
> -  through GITWEB_CONFIG_SYSTEM environmental variable.
> +  through the GITWEB_CONFIG_SYSTEM environment variable.

I really appreciate you killing this non-word I love to hate ;-)

> diff --git a/gitweb/README b/gitweb/README
> index 8dfe335..8f7ea36 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -2,7 +2,7 @@ GIT web Interface
>  =================
>  
>  The one working on:
> -  http://www.kernel.org/git/
> +  http://git.kernel.org/
>  
>  From the git version 1.4.0 gitweb is bundled with git.

While the URL is correct, neither the original nor your fix parses for me,
but if I have to guess, I think it wants to say "you can view a working
installation at this URL".
