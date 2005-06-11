From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 16:34:36 +1000
Message-ID: <2cfc403205061023346c03a25b@mail.gmail.com>
References: <E1DgodI-0003ov-Fl@highlab.com>
	 <7vy89h4m9r.fsf@assigned-by-dhcp.cox.net>
	 <E1DgyW0-0004PE-Ct@highlab.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 08:30:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgzVj-0004i1-La
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 08:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVFKGeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 02:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFKGeq
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 02:34:46 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:9614 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261610AbVFKGeg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 02:34:36 -0400
Received: by rproxy.gmail.com with SMTP id i8so389151rne
        for <git@vger.kernel.org>; Fri, 10 Jun 2005 23:34:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CDApKaKy0SDx+hg08lnpVws64dXdccnXi+4qGxMu7dm+K+k7EEh0LH+VAAWaYoglSCzLywPCSM9P/QROjQ+0fVs2aEOiZBWV659x/+A1BNoGkm3dgx5kaSJskoS2XrinKbxn9VYoRJIAnPaXYhp7rJpPo4lyf2jWH+6RV50EUn4=
Received: by 10.38.150.2 with SMTP id x2mr31519rnd;
        Fri, 10 Jun 2005 23:34:36 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Fri, 10 Jun 2005 23:34:36 -0700 (PDT)
To: Sebastian Kuzminsky <seb@highlab.com>
In-Reply-To: <E1DgyW0-0004PE-Ct@highlab.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sebastian,

What is the justification for removing it?

As it stands, git serves a useful function in that it provides a
single point through which access to all git-*-scripts is channeled,
yet still allows each script to be maintained as a separate entity,
coherent entity.

jon.
