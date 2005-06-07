From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Tue, 7 Jun 2005 19:30:09 +1000
Message-ID: <2cfc40320506070230680743f5@mail.gmail.com>
References: <20050607091523.14051.qmail@blackcubes.dyndns.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 07 11:27:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfaMF-0004Lx-I7
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 11:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVFGJaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 05:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVFGJaQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 05:30:16 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:30841 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261812AbVFGJaM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 05:30:12 -0400
Received: by rproxy.gmail.com with SMTP id i8so148623rne
        for <git@vger.kernel.org>; Tue, 07 Jun 2005 02:30:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eCPx61Ob6hoz1EcI6dMWyb6C8aciMOwtPG6m0b+Ov5Vn9vxFuQT4BKbzx0/k3jFs6ZZoBzvc2mQHMBdUhRZXxKff4TLSpVSpSJn16HoUj74ZCUhBm7qOY0JN7gxtJwfBHbkCMr2KNpvbBTZAPQZkK6QKDoSR1mjGBBmJcVPxR5k=
Received: by 10.39.3.31 with SMTP id f31mr370799rni;
        Tue, 07 Jun 2005 02:30:09 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 7 Jun 2005 02:30:09 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050607091523.14051.qmail@blackcubes.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A small update to the patch which corrects a couple of documentation typos and a
slight correction to git-rev-list options processing has been posted
here. The update has been tested with a complete apply+build from the
base commit.

http://blackcubes.dyndns.org/epoch/wrt-patch.patch

Regards,

jon.
