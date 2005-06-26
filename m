From: Martijn Kuipers <martijn.kuipers@gmail.com>
Subject: Re: [RFD] consider "git" wrapper semi-Porcelain
Date: Sun, 26 Jun 2005 13:36:30 +0100
Message-ID: <42BEA14E.8010806@gmail.com>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>	<7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>	<7vy88yvsjl.fsf_-_@assigned-by-dhcp.cox.net>	<Pine.LNX.4.58.0506251821050.19755@ppc970.osdl.org> <7voe9ts4vt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jun 26 14:30:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmWGu-0002IZ-Dm
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 14:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFZMgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 08:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFZMgl
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 08:36:41 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:57408 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261192AbVFZMge (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2005 08:36:34 -0400
Received: from [192.168.8.10] ([85.138.8.126] RDNS failed) by exch01smtp11.hdi.tvcabo with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 26 Jun 2005 13:36:33 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe9ts4vt.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 26 Jun 2005 12:36:33.0875 (UTC) FILETIME=[AFB22230:01C57A4B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> - renames most of the git-*-script to git-*-cmd;

Wouldn't this ruin the nice tab-completion? git-plumbing and 
git-porcelain will only be distinctable from their last part.
Maybe I understood wrong, but if people are supposed to "just" use 
git-porcelain for every day use, then probably it would make more sense 
to rename to gitp-* for porcelain, as the tab-completion would work from 
the first word , which would be less confusing for us mere users (yes, 
any alternative first word would work).

Kind regards,
Martijn

