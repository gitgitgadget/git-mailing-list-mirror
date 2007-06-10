From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Sun, 10 Jun 2007 12:10:37 +0200
Message-ID: <8c5c35580706100310s7e08c22ake8956e2aaa216978@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <11814251322779-git-send-email-hjemli@gmail.com>
	 <20070610002802.GD31707@planck.djpig.de>
	 <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
	 <Pine.LNX.4.64.0706101048120.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Sven Verdoolaege" <skimo@kotnet.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 12:10:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxKNc-0000O9-8a
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 12:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbXFJKKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 06:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbXFJKKj
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 06:10:39 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:11185 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbXFJKKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 06:10:38 -0400
Received: by py-out-1112.google.com with SMTP id a29so2085480pyi
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 03:10:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gvMcWgjNfa1Tpk8SVTqFAElwS0lZ9SZYE5KWmS4QIK2uxJI8WlKjLz8wZF4BHUXquwnpvdrFn4dK3/KuQXPkbGaJUotOehHSxpgs4f/kqMb2+1s1l3p7p1rZttvnetSw4W7nFFTWIE2aMNVaiF8uQ1yJ3I28fOUAQm8QnEDpGiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sPnNnuL7hDNSHywPepWMVxAxOhohdYkPGWBYSMUdf8Iat/qlLjn9aVEhm0wj3sZrPHUiYQmSFEtF31MinQC1vBTfrAoxz6ZBQhAsqSB91BQixr/Z9wRRjehW7GV/MLnYUmR8mMvZ7c2XzbEdkvJWD+tetOPYfOIzZwaeRW7k9d4=
Received: by 10.114.179.1 with SMTP id b1mr4376399waf.1181470237577;
        Sun, 10 Jun 2007 03:10:37 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sun, 10 Jun 2007 03:10:37 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706101048120.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49706>

On 6/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 10 Jun 2007, Lars Hjemli wrote:
>
> > Shame on me for drinking while documenting ;-)
>
> So I'm not the only one trying to cheer me up with some ethanol-containing
> beverage, when writing documentation?
>

Nope, you're not alone. Certain activities do require lots of stimuli
(also known as "Gourmet Stout" :)

-- 
larsh
