From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 02 Oct 2011 18:57:55 +0200
Message-ID: <4E889813.8070205@gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com> <CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com> <CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com> <CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com> <CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com> <CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com> <CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com> <CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com> <CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com> <CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com> <CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com> <CAE1pOi0Er1ZgftpNeCr85Zu27xR
 2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com> <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com> <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 18:58:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAPMm-0002Ny-6D
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 18:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab1JBQ6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 12:58:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55827 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab1JBQ6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 12:58:00 -0400
Received: by bkbzt4 with SMTP id zt4so4269431bkb.19
        for <git@vger.kernel.org>; Sun, 02 Oct 2011 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=seRHU2EdWvxP7mCLPwC4xghLL4tXuvwJb7ohCyo50Bc=;
        b=dTmwr9hl9Lrh+3g6iyUCRQkH13yAA9dMV1grRp973bA6+GhXIj9+oUz1fTFpkPZ7DQ
         oXq9a/4E+tn3ij3CUdHiqArzoG0Db/Zs4oYAdInB76VFJ31vhkyrTmYbwb7N9zi8tNpm
         FE/EBSnc68c50+DgzGg7Pd94M1jIgb8eqnpgY=
Received: by 10.204.140.149 with SMTP id i21mr3504741bku.306.1317574678670;
        Sun, 02 Oct 2011 09:57:58 -0700 (PDT)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h212n2fls34o828.telia.com. [213.67.13.212])
        by mx.google.com with ESMTPS id j16sm10576032bks.3.2011.10.02.09.57.56
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Oct 2011 09:57:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:7.0) Gecko/20110916 Thunderbird/7.0
In-Reply-To: <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182606>

Hilco Wijbenga skrev 2011-08-22 22.10:
> [...] I just wish there was at least an option to
> keep the timestamp (and possibly other such things). Even Subversion
> can do that... ;-) After all, not everybody uses C&  make.
>
What tools do you use that need the benefits from retaining timestamps? 
The only
one I can think of is clearmake, but then that tool goes with another 
SCM. Eclipse,
for example, will be just as confused by timestamps that travel 
backwards in time, as
make is.

-- robin
