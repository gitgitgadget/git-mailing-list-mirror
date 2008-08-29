From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: How to create a branch without any links to the others branches
Date: Fri, 29 Aug 2008 21:18:29 +0200
Message-ID: <38b2ab8a0808291218t60be4d04u6c429f7b6c8e3f19@mail.gmail.com>
References: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
	 <81b0412b0808290227g328b793cl58a606e718b4b3ff@mail.gmail.com>
	 <38b2ab8a0808290237l703b0394rad8f42c091d7143f@mail.gmail.com>
	 <81b0412b0808290246j299371b0k7895308368266a01@mail.gmail.com>
	 <38b2ab8a0808290517l75296521rf99f724cb1594f69@mail.gmail.com>
	 <7v4p536exq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:20:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ9VR-0008T8-U9
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 21:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbYH2TSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 15:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756044AbYH2TSb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 15:18:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:29167 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928AbYH2TSa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 15:18:30 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1384202ugf.37
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y8Ppwjcu6tta2QO8TJnsSRfrVsYroXIazXRewVzjDAc=;
        b=hXYns82XVOOEMmMIaJhHPC1ZP2GXLGqVzZjaqss+BSCTlftclWfxd4Q9c8KYxeXBhj
         SgJMIaX2uOfmHBQDbCWsgCuepWZrXd8VwXVo5J1Qxiad58JPTGQ/Jc9rgoFln0yYES3h
         +iBGX6jjURPP7CHM9Tz1pAIS3f5guApQISp0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ix1Wu4rwjkSul6bIG6XWF72kJifrTfPLYfO2MJXTkaLUxcv+OZUwBgf/NFokTv1Gos
         1obZVHJvhHc1UfQtqm9CstvLdQIsKwQtCd+mwxo1sKDG8xxxUHyU33Rxvw4ZI0uT2o6d
         TweYN5lsasIen4TGRBTQaHNz5hYSt6bfmG/8c=
Received: by 10.67.29.4 with SMTP id g4mr4922538ugj.73.1220037509545;
        Fri, 29 Aug 2008 12:18:29 -0700 (PDT)
Received: by 10.67.22.17 with HTTP; Fri, 29 Aug 2008 12:18:29 -0700 (PDT)
In-Reply-To: <7v4p536exq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94316>

On Fri, Aug 29, 2008 at 5:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If that is the objective...
>
> There is no reason whatsoever for these unrelated branches to _ORIGINATE_
> from the same source repository.

Well I find sometimes convenient to embed some temporary working files
and the project files at the same place.

>  The repositories you see at kernel.org
> and repo.or.cz are merely public distribution points, and I push them into
> a single repository at each of these places merely for downloaders
> convenience, from separate repositories.

OK.

thanks
-- 
Francis
