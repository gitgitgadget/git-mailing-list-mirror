From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Sun, 11 Sep 2005 23:07:18 +1200
Message-ID: <46a038f9050911040762f53552@mail.gmail.com>
References: <deofnh$jl0$1@sea.gmane.org>
	 <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 13:08:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEPgE-00087m-Hr
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 13:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVIKLHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 07:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVIKLHY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 07:07:24 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:50351 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932467AbVIKLHX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 07:07:23 -0400
Received: by rproxy.gmail.com with SMTP id i8so249269rne
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 04:07:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AWvkle9mlT1im+x2sMXY6xsaWoywxNyw/WGa7t+GqlcLmaH0EADvDBflTN10gJ22L8ZDs9NeUYeOF3sE+VH1D6qwi9Zgn3AbuJG54Zy3f929CGN+3iqFV+dTE2378+Ua0ZPEmqPQDMykNkZBBs0Nx37jCqXQnTEu6GyIdTgDEPM=
Received: by 10.38.97.6 with SMTP id u6mr193999rnb;
        Sun, 11 Sep 2005 04:07:18 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 11 Sep 2005 04:07:18 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8292>

On 9/11/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> - gitk gets very confused about the window layout. My preliminary tests on
>   cygwin showed that this seems to be rather a problem of Tk with rootless
>   Xwin. I worked around it by explicitely stating the dimensions of some
>   canvas windows which would not automatically resize with their contents
>   otherwise.
 
Can you share that fix? 

cheers,


martin
