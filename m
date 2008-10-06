From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 2/6] Remove TODO items that have already been addressed
Date: Mon, 6 Oct 2008 21:43:47 +0100
Message-ID: <b0943d9e0810061343g3f675356x960aff02e519bb36@mail.gmail.com>
References: <20081005155450.19886.43748.stgit@yoghurt>
	 <20081005160140.19886.92390.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 22:45:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmwwu-0002Hn-7w
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 22:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbYJFUns convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 16:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbYJFUns
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 16:43:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:38318 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbYJFUns convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 16:43:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3141516rvb.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ryVej+Ue5lEfUusM6D+VAS4ZhYOqA9ruoozEa9XvXGY=;
        b=twomhSzW7ukSq58Vuwpjf6edujGwoOvp546Sq0ETXalikwoMknnVipCD2hyNlbidx1
         dCXJlIyGGyf/tobrQvmH8cYcXZSvESjI0szZ9K9lLOsSJikLEHQjmzU8Y672OVCW95Ct
         0mragLHY+iXQdYhrP0AWjLsjfEFBHegMubDE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Hnv7gRtw9v7FaqmVXgHZeuOH4iHzee0MB89uLYAmER+e0AqxEOlebbzFB6Pz38QurH
         t3kKqyAVyfWk19Md8UFp9ergOmKbtuyv+W3Gipjsn5OolHIypS4GGGbQQaPc78IchEbw
         FU6/j4Cvaa5v311CG69G0yxbAnQu2ly/36Q2s=
Received: by 10.141.68.12 with SMTP id v12mr3367000rvk.111.1223325827288;
        Mon, 06 Oct 2008 13:43:47 -0700 (PDT)
Received: by 10.141.201.12 with HTTP; Mon, 6 Oct 2008 13:43:47 -0700 (PDT)
In-Reply-To: <20081005160140.19886.92390.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97626>

2008/10/5 Karl Hasselstr=F6m <kha@treskal.com>:
>  TODO |    9 ---------
>  1 files changed, 0 insertions(+), 9 deletions(-)

We could also drop this file entirely since we have a Tasks list on
the gna.org project page.

--=20
Catalin
