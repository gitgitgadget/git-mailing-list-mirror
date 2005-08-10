From: Wolfgang Denk <wd@denx.de>
Subject: Re: Cannot install git RPM
Date: Wed, 10 Aug 2005 21:44:59 +0200
Message-ID: <20050810194459.8584D353C12@atlas.denx.de>
References: <20050810163202.GA11131@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Wright <chrisw@osdl.org>, Wolfgang Denk <wd@denx.de>,
	Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 21:46:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2wWA-0005Ka-2R
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 21:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVHJTpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 15:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbVHJTpa
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 15:45:30 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:22214 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030220AbVHJTp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 15:45:29 -0400
Received: from fwd21.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1E2wVk-0003fp-03; Wed, 10 Aug 2005 21:45:12 +0200
Received: from denx.de (TQJVcwZHQeWzYvOS8MHJXeBFs-JC7KPXvYBF39aJvWu6OtMGVbaT0+@[84.150.65.8]) by fwd21.sul.t-online.de
	with esmtp id 1E2wVZ-21HhXE0; Wed, 10 Aug 2005 21:45:01 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id A1D2D42CB3; Wed, 10 Aug 2005 21:44:59 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 8584D353C12;
	Wed, 10 Aug 2005 21:44:59 +0200 (MEST)
To: Sam Ravnborg <sam@ravnborg.org>
In-reply-to: Your message of "Wed, 10 Aug 2005 18:32:02 +0200."
             <20050810163202.GA11131@mars.ravnborg.org> 
X-ID: TQJVcwZHQeWzYvOS8MHJXeBFs-JC7KPXvYBF39aJvWu6OtMGVbaT0+@t-dialin.net
X-TOI-MSGID: 0612d556-fbbb-4e32-a254-bacbc1398db3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <20050810163202.GA11131@mars.ravnborg.org> you wrote:
>
> Not knowing perl at all I wonder if some more widespread used packages
> can replace the above two?

Installation of the required modules from the  CPAN  is  trivial.  It
should be documented somewhere, though.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"UNIX was not designed to stop you from doing stupid things,  because
that would also stop you from doing clever things."       - Doug Gwyn
