From: "David S. Miller" <davem@davemloft.net>
Subject: Re: t6021-merge-criss-cross.sh fails on some systems
Date: Sun, 11 Dec 2005 00:12:02 -0800 (PST)
Message-ID: <20051211.001202.29022250.davem@davemloft.net>
References: <20051211003353.GA27207@c165.ib.student.liu.se>
	<20051210.235818.90276521.davem@davemloft.net>
	<7v64pwoy45.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 09:12:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElMJ9-00068E-11
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 09:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVLKILo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 03:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVLKILo
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 03:11:44 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8417
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751334AbVLKILo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 03:11:44 -0500
Received: from localhost.localdomain
	([127.0.0.1] helo=localhost ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.54)
	id 1ElMJS-0005pT-Uz; Sun, 11 Dec 2005 00:12:07 -0800
To: junkio@cox.net
In-Reply-To: <7v64pwoy45.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13489>

From: Junio C Hamano <junkio@cox.net>
Date: Sun, 11 Dec 2005 00:07:38 -0800

> Next such round would fail at "make test" stage with t0000;
> otherwise please let me know

t0000-basic.sh looks wonderful, thanks :)
