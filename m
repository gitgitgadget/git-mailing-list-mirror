From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull opinion
Date: Mon, 5 Nov 2007 23:22:33 -0500
Message-ID: <3abd05a90711052022j590f1faesb85f4646afd9acec@mail.gmail.com>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
	 <fgo5dt$avh$1@ger.gmane.org>
	 <Pine.LNX.4.64.0711060007010.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 05:22:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpFxk-0001Yn-Bi
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 05:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbXKFEWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 23:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbXKFEWg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 23:22:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:61113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbXKFEWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 23:22:35 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1574562nfb
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 20:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MLHxxSCAwLVVlKAGE/VQx4t56iMsh68lZ4KQyy/dP+U=;
        b=j1HfqnXr6efSIXKr7LUq1zOxJkhx5IN/VrxLbk0F+Eo4n94qpjpFZDcHznYAfGCuB3i4wKNWT4rzOyRUnQoaDl0sutPguhSc7tMoIcHzbgwDAAcyFdAB1FNno1hOBteDgmyw4zDtA2ZiAORZaJzFINpKGkLGUJKdmfdUnfePWAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=np+GhYPHmWLNU9a80CY6GN2R3VVGmkmjzdvFOZX6oPIilIWvL3NZI2N2J8j9CX0WFd3ivoNrxgj/p6eFFm/wBvprohpoTnWOnlqXwfbYUG4PI2BvLcZJ/t/GiU9dMtRiCk0GkpzqnShsHz8JxOv9K87XsdJn+NBSzz64x9VTVPs=
Received: by 10.78.132.2 with SMTP id f2mr4415320hud.1194322953405;
        Mon, 05 Nov 2007 20:22:33 -0800 (PST)
Received: by 10.78.185.1 with HTTP; Mon, 5 Nov 2007 20:22:33 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711060007010.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63623>

Hello,

> The consense was that you are much better off committing first, then
> pulling.  And if the work you are doing really is not committable, but you
> _have_ to pull _now_, you use stash.  Although you are quite likely to
> revert the pull when it succeeds, and _then_ unstash.

Sorry but I don't really understand why one should "revert the pull" ? Could
elaborate for a newbie ? :)

- Aghiles.
