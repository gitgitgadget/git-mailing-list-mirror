From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: Perl version support (was Re: [PATCH] git-mv is not able to handle big directories)
Date: Wed, 23 Nov 2005 17:02:40 -0500
Message-ID: <118833cc0511231402k5fba4e1ta7704efbc5889b23@mail.gmail.com>
References: <200511231141.57683.lan@ac-sw.com>
	 <7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
	 <7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
	 <867jazre78.fsf@blue.stonehenge.com>
	 <7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
	 <20051123135604.GB16995@mythryan2.michonline.com>
	 <86mzjvphhj.fsf_-_@blue.stonehenge.com> <4384E574.8060801@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 23:06:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef2ho-0001Ww-1Z
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 23:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVKWWCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 17:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVKWWCn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 17:02:43 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:39448 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932564AbVKWWCl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 17:02:41 -0500
Received: by xproxy.gmail.com with SMTP id h26so326249wxd
        for <git@vger.kernel.org>; Wed, 23 Nov 2005 14:02:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KoHt8LfD6bNVVM1jQ93XcqLyyzjyhI4SPHW+0ChJzv9mEC4kUjGQgQ47KJfVYBxAh1xekz3U1d6nIZ0Q9xx7hMb+KZqwXKBaohk0+Vg+o2+wSrefJrrplACUI4qCikCS59loCQIehzREPi3TSpmmTyOn7H3/DLYTwQHPvYn5Mgg=
Received: by 10.65.105.3 with SMTP id h3mr1328527qbm;
        Wed, 23 Nov 2005 14:02:40 -0800 (PST)
Received: by 10.65.154.6 with HTTP; Wed, 23 Nov 2005 14:02:39 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4384E574.8060801@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12654>

> I'm very surprised you say that 5.6 is more prevalent than 5.8.

You are overestimating the update-eagerness of the world.

SunOS 5.8 seems to come with 5.005_03
SunOS 5.9 seems to come with v5.6.1.

("Seems" because I am only 99% sure no-one around here has mucked with
the perl in /usr/bin/.)

M.
