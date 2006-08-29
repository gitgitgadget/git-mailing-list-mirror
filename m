From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Check if pack directory exists prior to descending into it
Date: Tue, 29 Aug 2006 02:17:28 -0700
Message-ID: <7v1wqzoq8n.fsf@assigned-by-dhcp.cox.net>
References: <20060829091214.GA10155@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 11:17:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHziZ-00044l-RN
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 11:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWH2JQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 05:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWH2JQs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 05:16:48 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:4059 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932228AbWH2JQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 05:16:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060829091644.YVII18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Tue, 29 Aug 2006 05:16:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id FlGk1V00V4Noztg0000000
	Tue, 29 Aug 2006 05:16:45 -0400
To: Matthias Kestenholz <matthias@spinlock.ch>
In-Reply-To: <20060829091214.GA10155@spinlock.ch> (Matthias Kestenholz's
	message of "Tue, 29 Aug 2006 11:12:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26198>

Makes sense.  Thanks.
