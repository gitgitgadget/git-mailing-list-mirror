From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [PATCH 1/5] New merge tests
Date: Sat, 3 May 2008 15:00:39 -0700
Message-ID: <402c10cd0805031500m234dcc7bu72682e1b8b821d1e@mail.gmail.com>
References: <402c10cd0804232243u700f4f6fv130d69283c40ff1d@mail.gmail.com>
	 <m3tzhqp96h.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 00:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsPnT-0001RU-78
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 00:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbYECWAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 18:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbYECWAr
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 18:00:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:57460 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbYECWAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 18:00:46 -0400
Received: by fk-out-0910.google.com with SMTP id 18so99526fkq.5
        for <git@vger.kernel.org>; Sat, 03 May 2008 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yHbecmq3ogRHSqpL34eIAOc0exC6qf8dx5PkXF4zX2g=;
        b=Xs6+RyK1fWf4pLy1hqhQXLLuqNTTqoY6+5dx/sFVa/1n9sin0B04vUhGyzhyqRAmA9gNF1snNLrjmZ7oH6tMbfQDzq6Hfcr2SBSA7DqGqkJNVKc4GKZbdvJYBF2ndSKQFuKkGtrqGrwKv19+1kLoy0H3VXtyYDPqgclhDrs9F4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g7RJs41eGEsAjCd1YcbZ/AvwSTs454rtGMha7VUcl5408RkgkKnNIGOH52C5jH+IgKWAWQL6LwFZqtgzchU1+KYgTIJbq9uoe1tK8YoZIDpaSV3Ga9Ei/YaeYl2cAJBt+7MTgxfX6EbMm0icHDaNwda7shla4sRnLR1fLCvXKiE=
Received: by 10.82.138.6 with SMTP id l6mr433615bud.88.1209852044912;
        Sat, 03 May 2008 15:00:44 -0700 (PDT)
Received: by 10.82.172.1 with HTTP; Sat, 3 May 2008 15:00:39 -0700 (PDT)
In-Reply-To: <m3tzhqp96h.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81118>

On Fri, Apr 25, 2008 at 2:37 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
>  I think you should describe here _what_ is tested by the new test(s),
>  and how it is named.

I do not intend to use more time on this.  They follow more or less
the same outline as t7600.

-- 
Sverre Hvammen Johansen
