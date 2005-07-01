From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: verify_pack.c vs verify-pack.c
Date: Fri, 1 Jul 2005 12:01:26 +1000
Message-ID: <2cfc4032050630190144e86cff@mail.gmail.com>
References: <Pine.LNX.4.63.0506301336460.1667@localhost.localdomain>
	 <7vy88r1tcp.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0506301631480.1667@localhost.localdomain>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 03:55:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoAjQ-0005B7-JG
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 03:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbVGACBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 22:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbVGACBh
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 22:01:37 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:1565 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263170AbVGACB3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 22:01:29 -0400
Received: by rproxy.gmail.com with SMTP id i8so196679rne
        for <git@vger.kernel.org>; Thu, 30 Jun 2005 19:01:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ous1WdGKpZ26A7QhEK5SvDaOfoFFOyFgUX8mEtKa7MBXsnIqJXG9fyk5pYw0kwarCIbAFd2TD4euY4IZFWHqoq+XGvGSRWKcuCyFUkNu+wM3JzAXRGGoouf0dlq8Vj6E77hGV8aedlElUXWbjkMMQ3HfOj8Z2U0n8jw/sf3w1g0=
Received: by 10.38.209.48 with SMTP id h48mr924107rng;
        Thu, 30 Jun 2005 19:01:26 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 30 Jun 2005 19:01:26 -0700 (PDT)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0506301631480.1667@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think this is odd too..

Why not rename the one containing the main as:

verify-pack-main.c

jon.
