From: Left Right <olegsivokon@gmail.com>
Subject: Re: [bug report, possibly] Multiple pushes with passwords in URL
Date: Mon, 2 Jul 2012 12:09:14 +0300
Message-ID: <CAJQBtgmg=-7TxKzEp7SH68UpMmGJha7kQ_MrhTVr+CPDp-WfHA@mail.gmail.com>
References: <CAJQBtg=yg_T=Vfq--9oivbbK86bxqLONTOBSRA+wSp2iiHGaTA@mail.gmail.com>
	<CAJQBtg=-drwKEU2iSDeUWZPbO+OENNL-rDMoy6XYPrnzFV1VyQ@mail.gmail.com>
	<CAJQBtg=XN1Txsp8Q3C=GgxyZQvCK3vAJouJkXfZgwtG9hvuubw@mail.gmail.com>
	<CAO54GHCS+KYeUYjK5oStJpi_Ztw5bXduCUqWecoi-QzDEFjG8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Mon Jul 02 11:10:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slcdy-0007nz-94
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 11:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818Ab2GBJJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 05:09:59 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38326 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932754Ab2GBJJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 05:09:15 -0400
Received: by obbuo13 with SMTP id uo13so7931007obb.19
        for <git@vger.kernel.org>; Mon, 02 Jul 2012 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h9A5I0YD39ty81Tbs7QJsYCS+IEv70zfe8X/l1Ozwkw=;
        b=IsyTiKJPfQ1bh0iI91vbPWUoqr0zZmL9vo1UDqeu/Y2HkCDlEy5W/RGs2/ZI2nRKoQ
         NG3DviZ+Fq4f8uKt63ErmqiyHINsPAgXDtZrrftN8TmAUMvvujb3ZWkB26aWESsHIuJ3
         TPXcXwM4zuxuiuDzQxkYGHCYGyBB3xa+tBvLoNaR9nJNDnfemvE/RZaQ0q9Lin3LYVlB
         arIxUynO7lPBwNNdaXCZgTRSyHFnd1RHtxhXvza0pDC+724aGrOsXmuHGeCW9GhD/wYb
         r6iOlQ5+XR4yntsJy+6LILUAb3bZUdrJ9jwKXY9tM3YQfDc1VJy6Nn8u7BN/p21mDWEs
         TWlg==
Received: by 10.182.15.103 with SMTP id w7mr7031432obc.26.1341220154886; Mon,
 02 Jul 2012 02:09:14 -0700 (PDT)
Received: by 10.76.120.45 with HTTP; Mon, 2 Jul 2012 02:09:14 -0700 (PDT)
In-Reply-To: <CAO54GHCS+KYeUYjK5oStJpi_Ztw5bXduCUqWecoi-QzDEFjG8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200851>

I have Git version 1.7.2.5 (this is what Debian repository provides), so

$ git help -a | grep credential-

doesn't find anything. But thanks, I've put that page into favorites.
Once there will be a newer version, I'll try that.

Best.

Oleg
