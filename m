From: "Mike Coleman" <tutufan@gmail.com>
Subject: Re: [PATCH] fix some doc typos and grammar
Date: Fri, 2 Feb 2007 01:26:25 -0600
Message-ID: <3c6c07c20702012326h551b9f32gb3d8238361105741@mail.gmail.com>
References: <3c6c07c20702012225v19b7aa66vc98a028f700914db@mail.gmail.com>
	 <7vmz3xjbxv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 08:26:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCsoZ-0005kC-JK
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 08:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422973AbXBBH02 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 02:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423184AbXBBH02
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 02:26:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:32333 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422973AbXBBH01 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 02:26:27 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1169720nfa
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 23:26:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g4riNsUdB1HfQ1FnO4ehDThGvjMcyhujAjsc41pVKRzRx+qWKkdfapl9vdy4fYeKlafV7rp9bgfntLyobAf42Gcjg3zJHe1fy8jy5VPOKBEeB08yAtS7IoJ5a33oitGLbhSYySdqLPJjWGpFiEjt0m8wz2gsuEQUQXEdjhCfV6A=
Received: by 10.48.48.18 with SMTP id v18mr6006835nfv.1170401185735;
        Thu, 01 Feb 2007 23:26:25 -0800 (PST)
Received: by 10.48.246.15 with HTTP; Thu, 1 Feb 2007 23:26:25 -0800 (PST)
In-Reply-To: <7vmz3xjbxv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38469>

On 2/2/07, Junio C Hamano <junkio@cox.net> wrote:
> It is usually nicer to put this "cover letter" material below
> the three dashes after Signed-off-by line; not a huge deal,
> though.

I remembered that the three dashes mattered, but I couldn't remember
if it was above or below.

It turns out that it's fairly easy to configure gmail to accept an
SMTP connection.  This recipe shows how to configure ssmtp, which is
just a really dumb sender, to work with gmail:

    http://www.destr0yr.com/article.php/Gmail_and_sSMTP

This makes git-send-email work directly, and avoids the gmail web MUA.

> Ah, "which or that", very funny.  At work today I was working
> with somebody you know (AB) on a document, and he was fixing my
> that to which.  Now you are fixing my which to that.

Amusingly enough, it was PE who taught me the difference between
'that' and 'which' in the first place.  Tell AB that MC says "Hi".
:-)

Mike
