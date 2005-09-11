From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Omit patches that have already been merged from format-patch output.
Date: Mon, 12 Sep 2005 09:08:45 +1200
Message-ID: <46a038f90509111408f9479e2@mail.gmail.com>
References: <46a038f905091101529e045af@mail.gmail.com>
	 <7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:10:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEZ4C-0003QY-WC
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 23:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVIKVIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 17:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVIKVIq
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 17:08:46 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:44452 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750873AbVIKVIp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 17:08:45 -0400
Received: by rproxy.gmail.com with SMTP id i8so279728rne
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 14:08:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SFadNKqBJsCLAMbnZ12AlHt7x1nrUmf4KGa7LwbGhvxNWi5HzZ7CPBhqjkcdU0UaM/ZawI85TV1+kc69UiAe/N25nn6q3fqCDMNBkRSSeVw/VRuge7tJ9mid7NtIVk423nGrgEq72A/h/StUA0v1sAp1mXGaP6MjvRnjes4PELE=
Received: by 10.38.209.6 with SMTP id h6mr230533rng;
        Sun, 11 Sep 2005 14:08:45 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 11 Sep 2005 14:08:45 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8332>

>  git-cherry).  One thing I am reluctant about this is it breaks the
>  exact example Johannes just posted.

Well, Johannes example didn't work at all for me. Output was empty,
when I was expecting 4~6 entries.

cheers,

martin
