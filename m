From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIt.xs merge status
Date: Fri, 30 Jun 2006 03:26:40 -0700
Message-ID: <7vodwbj5wf.fsf@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<7vmzbvmny4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606301150250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 12:26:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwGD0-0006tg-Bo
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 12:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWF3K0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 06:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWF3K0n
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 06:26:43 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:22263 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932233AbWF3K0m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 06:26:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630102641.LGIU19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 06:26:41 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606301150250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 30 Jun 2006 11:53:53 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22978>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'll try it (it's in pu, right?). Note that breaking git-fmt-merge-msg 
> might be a good way to force somebody to rewrite it in C ;-)

It would hopefully not come to that (and that is I am playing
safe and keeping the series in "pu"), and even if it did, I am
hoping that Perl is so ubiquitous that people would fix it up
quickly.
