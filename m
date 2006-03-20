From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pulling tags from git.git
Date: Mon, 20 Mar 2006 12:31:49 -0800
Message-ID: <7vpskgkgcq.fsf@assigned-by-dhcp.cox.net>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>
	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>
	<440D5285.3050401@op5.se> <7voe0ilf25.fsf@assigned-by-dhcp.cox.net>
	<440D7A7D.8070507@op5.se> <87zmk0dq75.fsf@mid.deneb.enyo.de>
	<441064DD.2010903@op5.se> <87lkv5ynnp.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 21:32:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLR2m-0005U8-3p
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 21:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWCTUb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 15:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWCTUb4
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 15:31:56 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:12511 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030221AbWCTUbz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 15:31:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060320203027.EVLT3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Mar 2006 15:30:27 -0500
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <87lkv5ynnp.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
	"Mon, 20 Mar 2006 19:30:18 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17766>

Florian Weimer <fw@deneb.enyo.de> writes:

> It's not obvious from the git-tag documentation that signing makes a
> difference down the road in terms of replication.  IOW, I don't
> question the distinction per se, but it's counter-intuitive if you
> aren't told about it.

Agreed.  Please make it so ;-).
