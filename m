From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Tue, 6 Dec 2005 19:58:00 -0500
Message-ID: <118833cc0512061658g474edf35m4b1038fb739f0468@mail.gmail.com>
References: <7vslt67v9o.fsf@assigned-by-dhcp.cox.net>
	 <14331.1133899163@lotus.CS.Berkeley.EDU>
	 <118833cc0512061310r6398f812ia47a84d3cfad1564@mail.gmail.com>
	 <7vwtih299f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 02:01:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjndI-0004rg-W1
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 01:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVLGA6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 19:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbVLGA6D
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 19:58:03 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:33612 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030308AbVLGA6B convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 19:58:01 -0500
Received: by wproxy.gmail.com with SMTP id i27so204823wra
        for <git@vger.kernel.org>; Tue, 06 Dec 2005 16:58:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oYW4JX7AulQ6DQgbm6QmkHDNYhOjF8yARFlXIp5C4VOY6oz6Bk03wjPV4gju+gtT1JryrwGb2BPzazBWzmxM4VowWAGY2ADI3jYxjmlBIGaQ2Mrkl3ET0xTexWOEoIoKGJyzqoVq8zcuOMfhdp+EEy8oy/sRHx3xOKOjSfYh/YM=
Received: by 10.65.53.6 with SMTP id f6mr1227453qbk;
        Tue, 06 Dec 2005 16:58:00 -0800 (PST)
Received: by 10.65.151.1 with HTTP; Tue, 6 Dec 2005 16:58:00 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtih299f.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13313>

> Are you suggesting it to be done like this?

Precisely.

Morten
