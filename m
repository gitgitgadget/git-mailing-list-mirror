From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Tue, 09 May 2006 14:11:07 -0700
Message-ID: <7v7j4u3nv8.fsf@assigned-by-dhcp.cox.net>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
	<11471512103526-git-send-email-normalperson@yhbt.net>
	<20060509120809.4d9494b9.tihirvon@gmail.com>
	<20060509191803.GA3676@localdomain>
	<20060509231031.b62576da.tihirvon@gmail.com>
	<7vlktb2ayy.fsf@assigned-by-dhcp.cox.net>
	<20060510000826.1a708c03.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 23:11:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdZU9-0006wG-WF
	for gcvg-git@gmane.org; Tue, 09 May 2006 23:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWEIVLL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 17:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWEIVLL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 17:11:11 -0400
Received: from fed1rmmtai11.cox.net ([68.230.241.48]:33243 "EHLO
	fed1rmmtai11.cox.net") by vger.kernel.org with ESMTP
	id S1751012AbWEIVLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 17:11:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509211108.ZWKL21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 17:11:08 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060510000826.1a708c03.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Wed, 10 May 2006 00:08:26 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19851>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Better to support only -x=y or -x y, not both.

Didn't I just say -x=y where x is a single letter _is_ odd?
It is either -xy or -x y, not -x=y.
