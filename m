From: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
Subject: Re: pseudo initial empty commit and tag for git-log and git-describe?
Date: Thu, 21 Sep 2006 12:23:21 +0700
Message-ID: <fcaeb9bf0609202223u4f0bf2abv75d6d308637b0aef@mail.gmail.com>
References: <fcaeb9bf0609200658p3f04df7oe91ddb971787bd70@mail.gmail.com>
	 <1158761400.6516.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 07:23:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQH1y-0001XU-QN
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 07:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWIUFXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 01:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWIUFXW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 01:23:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:53355 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750832AbWIUFXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 01:23:22 -0400
Received: by wx-out-0506.google.com with SMTP id s14so541555wxc
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 22:23:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fxZSyn8/5JdQheHPmdiujcUkFMSt1xEru6Brqpgl/INh3CN5BwjgnRhpkY86Hn3K++cRutGKIuhYO6FHSM1U/mNFR9vcQ5vjiGipp8Pz99pcM8szzdaqkNXNWeGPQj8Sh0HIgoIEd6f2d0/u0u9375KGYIJMnN7V1C/56xLGc2Y=
Received: by 10.70.125.2 with SMTP id x2mr16430747wxc;
        Wed, 20 Sep 2006 22:23:21 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Wed, 20 Sep 2006 22:23:21 -0700 (PDT)
To: "Matthias Kestenholz" <lists@spinlock.ch>
In-Reply-To: <1158761400.6516.25.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27451>

On 9/20/06, Matthias Kestenholz <lists@spinlock.ch> wrote:
> hello
> you can use git log -p --root  to also display the root commit.
Thanks. I didn't know about --root.
-- 
Duy
