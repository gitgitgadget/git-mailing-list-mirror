From: James Purser <purserj@ksit.dynalias.com>
Subject: Re: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 15:37:12 +1000
Message-ID: <1115876231.3085.4.camel@kryten>
References: <Pine.LNX.4.21.0505120057250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 07:28:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW6F6-0006iy-H3
	for gcvg-git@gmane.org; Thu, 12 May 2005 07:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVELFfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 01:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVELFfk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 01:35:40 -0400
Received: from dsl-202-52-56-051.nsw.veridas.net ([202.52.56.51]:58754 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261155AbVELFfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 01:35:34 -0400
Received: from localhost.localdomain (kryten [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id j4C5bGAo005457;
	Thu, 12 May 2005 15:37:16 +1000
Received: (from purserj@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j4C5bCCU005456;
	Thu, 12 May 2005 15:37:12 +1000
X-Authentication-Warning: localhost.localdomain: purserj set sender to purserj@ksit.dynalias.com using -f
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505120057250.30848-100000@iabervon.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 15:19, Daniel Barkalow wrote:
> If you think about it as git and cogito being entirely separate projects,
> where users would be expected to have the right version of git most of the
> time (or ever), this is true. But I think that cogito is as closely tied
> to git as the kernel is to kbuild or kconfig; the difference is that git
> is not solely available with cogito, like kbuild is solely available with
> the kernel.
I tend to disagree with you on this point. Cogito and Git share
arelationship more akin to xorg and gnome and this is something I think
Linus intended so that it would be very easy to build a layer on top of
the git toolset. Cogito is great and it fills a need but give it time
and other implementations and tool sets will come along that may
supersede it.
-- 
James Purser
http://ksit.dynalias.com

