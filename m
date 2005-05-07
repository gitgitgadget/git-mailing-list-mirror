From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] Use backticks instead of $(command) to maintain /bin/sh compatibility
Date: Sat, 7 May 2005 12:15:30 +0200
Message-ID: <20050507101530.GH23680@cip.informatik.uni-erlangen.de>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de> <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net> <20050507090543.GG23680@cip.informatik.uni-erlangen.de> <20050507100348.GA16461@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 07 12:09:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUMF0-0000IE-LL
	for gcvg-git@gmane.org; Sat, 07 May 2005 12:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVEGKPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 06:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVEGKPf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 06:15:35 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:51146 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262946AbVEGKPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 06:15:32 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j47AFUS8007901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 7 May 2005 10:15:31 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j47AFU0Q007900
	for git@vger.kernel.org; Sat, 7 May 2005 12:15:30 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050507100348.GA16461@outpost.ds9a.nl>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> You can nest $() which is valuable, unlike backtics.

we're aware of this. But the specific script works perfectly fine
without nested simple-command redirection. So what is your point?

	Thomas
