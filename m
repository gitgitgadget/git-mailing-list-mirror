From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 0/2] Update git-send-email-script with --compose
Date: Tue, 6 Sep 2005 08:45:54 +1200
Message-ID: <46a038f905090513456d67842b@mail.gmail.com>
References: <11258971871874-git-send-email-ryan@michonline.com>
	 <46a038f905090504166246dc0a@mail.gmail.com>
	 <20050905153705.GD5335@mythryan2.michonline.com>
	 <7vll2b4ake.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90509051306212d4e93@mail.gmail.com>
	 <7vslwj2qty.fsf@assigned-by-dhcp.cox.net>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 22:47:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECNqv-0005v9-Gb
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 22:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVIEUqB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 16:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVIEUqB
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 16:46:01 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:43140 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932261AbVIEUqA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 16:46:00 -0400
Received: by rproxy.gmail.com with SMTP id i8so722107rne
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 13:45:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QoEKUaxoCa+DZKMWRZd+SRZayfXSSC1GLOuSJA0h0lAWxeWf9l2zTYZDq1wnVSiYTsu+niSE6FUL4BpWnUND0N7TCs+NswsYFuEIH/Tv1pCgkwJhxCr2FxT0BlYoKkv5MVxjWvsJ1Pt0Prj+Co8CQyYX/S6EnxYjrEDv6oH5df0=
Received: by 10.39.2.56 with SMTP id e56mr862545rni;
        Mon, 05 Sep 2005 13:45:54 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 5 Sep 2005 13:45:54 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslwj2qty.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8116>

On 9/6/05, Junio C Hamano <junkio@cox.net> wrote:
> Not really; --mbox output is one-file-per-patch and it is up to
> you which ones to pick and concatenate them in what order, if you
> want them in a single file.

Hrmmmm. Then I better hide away in a little cave, and shut my big mouth up. ;-)

It shows that I was never familiar with the practices of linux
hackers. I've always read the references to mboxes holding patchbombs
meaning literally one mbox file with a zillion contatenated patches
received via email.

apologies,


martin
