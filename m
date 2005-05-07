From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] Use backticks instead of $(command) to maintain /bin/sh compatibility
Date: Sun, 8 May 2005 01:15:39 +0200
Message-ID: <20050507231539.GB2497@cip.informatik.uni-erlangen.de>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de> <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net> <20050507090543.GG23680@cip.informatik.uni-erlangen.de> <20050507172429.GJ3562@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 08 01:08:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUYPi-0006ph-Ao
	for gcvg-git@gmane.org; Sun, 08 May 2005 01:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVEGXPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVEGXPn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 19:15:43 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:48077 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262762AbVEGXPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 19:15:40 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j47NFdS8029789
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 7 May 2005 23:15:39 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j47NFdgA029788
	for git@vger.kernel.org; Sun, 8 May 2005 01:15:39 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050507172429.GJ3562@admingilde.org>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Coworker,

> huh? which broken shell does not understand $()?

/bin/sh under Solaris 9 for example. That is where I hit it initial.

	Thomas
