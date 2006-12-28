From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 16:49:11 -0800
Message-ID: <7vbqlo4zg8.fsf@assigned-by-dhcp.cox.net>
References: <200612271300.kBRD082j007703@laptop13.inf.utfsm.cl>
	<7vtzzh5dnv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 01:49:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzjSU-0006fN-MM
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 01:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWL1AtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 19:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWL1AtS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 19:49:18 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61153 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964832AbWL1AtS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 19:49:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228004912.GAKS15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 19:49:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 40pR1W00z1kojtg0000000; Wed, 27 Dec 2006 19:49:26 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <7vtzzh5dnv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 27 Dec 2006 11:42:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35495>

Junio C Hamano <junkio@cox.net> writes:

> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:
> ...
>> And what happens to the people who can't/won't display UTF-8? This is a
>> both a project wide configuration (how does stuff get saved) + a user/local
>> configuration (how to display stuff).
> ...
> Maybe i18n.displayencoding set to latin1 is what you are after?
> I think it might make sense...

I've done this and will be pushing the result out in 'next'
shortly, with a new test.  I find the result mostly sensible.
