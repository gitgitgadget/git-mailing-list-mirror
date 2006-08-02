From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 02 Aug 2006 10:43:22 -0700
Message-ID: <7virlbuj7p.fsf@assigned-by-dhcp.cox.net>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com>
	<7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
	<1154535801.19994.15.camel@cashmere.sps.mot.com>
	<20060802165333.GA22726@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 19:43:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Kki-0003Up-0J
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 19:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWHBRnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 13:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWHBRnZ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 13:43:25 -0400
Received: from fed1rmmtai02.cox.net ([68.230.241.57]:480 "EHLO
	fed1rmmtai02.cox.net") by vger.kernel.org with ESMTP
	id S932107AbWHBRnY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 13:43:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802174323.EELF1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 13:43:23 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060802165333.GA22726@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 2 Aug 2006 12:53:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24661>

Jeff King <peff@peff.net> writes:

> Why don't we have sensible compile-time defaults that can be overridden
> by a run-time config file like every other sane program?

I like that approach.
