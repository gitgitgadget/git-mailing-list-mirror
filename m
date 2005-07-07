From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 07 Jul 2005 16:54:11 -0700
Message-ID: <7v64vmf9zw.fsf@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<12c511ca05070716526954edd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 01:54:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqgCH-00076M-W3
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 01:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVGGXyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 19:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVGGXyU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 19:54:20 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:30084 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262355AbVGGXyS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 19:54:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050707235412.UGCM1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 19:54:12 -0400
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <12c511ca05070716526954edd@mail.gmail.com> (Tony Luck's message of "Thu, 7 Jul 2005 16:52:25 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TL" == Tony Luck <tony.luck@gmail.com> writes:

TL> Also "git-fsck-cache" in a repo that is fully packed complains:

TL>    fatal: No default references

"git-fsck-cache --full", perhaps?
