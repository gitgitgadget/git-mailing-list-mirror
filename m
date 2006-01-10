From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Mon, 09 Jan 2006 17:21:33 -0800
Message-ID: <7v1wzgg9nm.fsf@assigned-by-dhcp.cox.net>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net>
	<43C2CAED.8030304@cc.jyu.fi> <7vwth9f1nk.fsf@assigned-by-dhcp.cox.net>
	<43C2F7E2.4090909@cc.jyu.fi> <43C2FE4A.50203@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 02:21:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew8Ci-0005D0-Oe
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 02:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWAJBVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 20:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWAJBVi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 20:21:38 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:48834 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750783AbWAJBVh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 20:21:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110011904.LVJY20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 20:19:04 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C2FE4A.50203@op5.se> (Andreas Ericsson's message of "Tue, 10
	Jan 2006 01:22:34 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14394>

Andreas Ericsson <ae@op5.se> writes:

> I have no solution to this, apart from rewriting the Makefile on the
> fly whenever a release tarball is created.

Well, there is always an option to update the fallback version
number hardcoded in GIT-VERSION-GEN script, but that kind fo
defeats the whole idea of the current setup, so...
