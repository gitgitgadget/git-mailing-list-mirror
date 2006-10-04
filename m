From: Junio C Hamano <junkio@cox.net>
Subject: Re: pull-fetch-param.txt
Date: Tue, 03 Oct 2006 19:03:25 -0700
Message-ID: <7vzmccltw2.fsf@assigned-by-dhcp.cox.net>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>
	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>
	<452211C2.8020402@s5r6.in-berlin.de>
	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>
	<45222B18.1090305@s5r6.in-berlin.de>
	<7v64f1np8i.fsf@assigned-by-dhcp.cox.net>
	<4522E66B.4080103@methods.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
X-From: git-owner@vger.kernel.org Wed Oct 04 04:07:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUw6c-0001sE-Mh
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 04:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbWJDCD1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 22:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030703AbWJDCD1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 22:03:27 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27312 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030520AbWJDCD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 22:03:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061004020326.QPTC22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 22:03:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id W23K1V00P1kojtg0000000
	Tue, 03 Oct 2006 22:03:20 -0400
To: Stuart Rackham <srackham@methods.co.nz>
In-Reply-To: <4522E66B.4080103@methods.co.nz> (Stuart Rackham's message of
	"Wed, 04 Oct 2006 11:38:35 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28311>

Stuart Rackham <srackham@methods.co.nz> writes:

> From the AsciiDoc User Guide
> (http://www.methods.co.nz/asciidoc/userguide.html#X53):
>
> If you want to disable unconstrained quotes, the new alternative
> constrained quotes syntax and the new index entry syntax then you can
> define the attribute asciidoc7compatible (for example by using the -a
> asciidoc7compatible command-line option).
>
> --
> Stuart Rackham

Thank you for a quick reply.

Stefan, can you try it with the earlier commit to escape tilde
reverted and see if our documentation set behaves well?
