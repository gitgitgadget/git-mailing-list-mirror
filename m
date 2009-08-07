From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [ANNOUNCE] tortoisegit 0.9.1.0
Date: Fri, 7 Aug 2009 09:24:32 -0700
Message-ID: <fabb9a1e0908070924gda3fb09k21d5585083a4c6c1@mail.gmail.com>
References: <1976ea660908050700u9b16a8ci169825b121f02cb9@mail.gmail.com> 
	<e1a5e9a00908062225y112984d9gc0486ebcda25ab57@mail.gmail.com> 
	<43d8ce650908062348x3bbfac30w6be13ffce43b33d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tim Harper <timcharper@gmail.com>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com, tortoisegit@googlegroups.com
To: John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 07 18:25:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZSFc-0000oX-Bz
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 18:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbZHGQYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 12:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbZHGQYx
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 12:24:53 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:63023 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbZHGQYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 12:24:52 -0400
Received: by ey-out-2122.google.com with SMTP id 9so546079eyd.37
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=559HhseecREXWX+VBwyaMi315M6w0XQ4P0j8l+K22gE=;
        b=vq6V6fWf9JTjv7nG3FNefJcdAZ88UyTjulXvT8wU+zPQfGbmO81tOjsaKNSDoWOVJI
         78L62PDNbJ7IjAIQulrvCucLDIxw15136ymF4Uab5gepQAtTfgEi5hj8X7ItjjL1EL1c
         shnqD52G+RSGbCBpkbzlUtzysiubV+rJ3LGw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MQqCJuf8/3maVrOvG/TYWig3Ak4IXXzvcSczlDz7P50MCbnReIZxU8sGh2HzcLEcZn
         RyA1Ma1C4w4nMo/edyjv7KD0azAe5tLsqQpYZaWDU1aGhmrLoyQ4wm/bqdeZ4CnUTuzs
         GoDMmCmTuF67E1wzscvnx7aX/V5EmX3RmpAmI=
Received: by 10.216.55.195 with SMTP id k45mr281102wec.70.1249662292114; Fri, 
	07 Aug 2009 09:24:52 -0700 (PDT)
In-Reply-To: <43d8ce650908062348x3bbfac30w6be13ffce43b33d9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125205>

Heya,

On Thu, Aug 6, 2009 at 23:48, John Tapsell<johnflux@gmail.com> wrote:
> How hard would it be to port this to KDE?

Impossible.

> What would be involved?

Port all Windows specific code; instead, you should have a look at
git-cheetah, which aims to do the same thing, only platform agnostic.

-- 
Cheers,

Sverre Rabbelier
