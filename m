From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem cloning the Linux history tree
Date: Fri, 04 Nov 2005 10:38:05 +0100
Message-ID: <20051104093805.2880D353C33@atlas.denx.de>
References: <20051104092626.GL1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Marcel Holtmann <marcel@holtmann.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 10:40:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXy1k-0003ZQ-Nr
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 10:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbVKDJiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 04:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbVKDJiH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 04:38:07 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:17849 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S932720AbVKDJiG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 04:38:06 -0500
Received: from mail.m-online.net (svr20.m-online.net [192.168.3.148])
	by mail-out.m-online.net (Postfix) with ESMTP id 72D157010A;
	Fri,  4 Nov 2005 10:36:44 +0100 (CET)
X-Auth-Info: nmGes0X/jjggGIkO1mWd+HNifMzqahS1AbI/PNK9RzY=
X-Auth-Info: nmGes0X/jjggGIkO1mWd+HNifMzqahS1AbI/PNK9RzY=
X-Auth-Info: nmGes0X/jjggGIkO1mWd+HNifMzqahS1AbI/PNK9RzY=
X-Auth-Info: nmGes0X/jjggGIkO1mWd+HNifMzqahS1AbI/PNK9RzY=
Received: from mail.denx.de (p549660AA.dip.t-dialin.net [84.150.96.170])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id A4A451270F7;
	Fri,  4 Nov 2005 10:38:05 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 3CA096D00AC;
	Fri,  4 Nov 2005 10:38:05 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 2880D353C33;
	Fri,  4 Nov 2005 10:38:05 +0100 (MET)
To: Petr Baudis <pasky@suse.cz>
In-reply-to: Your message of "Fri, 04 Nov 2005 10:26:26 +0100."
             <20051104092626.GL1431@pasky.or.cz> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11125>

In message <20051104092626.GL1431@pasky.or.cz> you wrote:
> 
> > 09:58:42 ERROR 404: Not Found.
> > 09:58:42 URL:http://www.denx.de/git/linux-2.6-denx.git/refs/tags/DENX-2005-10-02-18:30 [41/41] -> "refs/tags/DENX-2005-10-02-18:30" [1]
> > ...
> > Missing object of tag v2.6.14-rc3... unable to retrieve


> And what exactly is the problem? It seemed to clone ok.

There was a 404 error, and the "Missing object of tag" message.



Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It usually takes more than three weeks to prepare  a  good  impromptu
speech.                                                  - Mark Twain
