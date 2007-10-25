From: Federico Mena Quintero <federico@novell.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007
	unfinishedsummary continued
Date: Thu, 25 Oct 2007 13:06:02 -0500
Message-ID: <1193335562.4522.403.camel@cacharro.xalalinux.org>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
	 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>
	 <Pine.LNX.4.64.0710231155321.25221@racer.site>
	 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>
	 <20071024194849.GH29830@fieldses.org>
	 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de>
	 <20071024212854.GB6069@xp.machine.xx>
	 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>
	 <Pine.LNX.4.64.0710242258201.25221@racer.site>
	 <1193328386.4522.352.camel@cacharro.xalalinux.org>
	 <20071025163835.GB31888@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:04:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il744-0007Sy-R6
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbXJYSED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbXJYSED
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:04:03 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:27760 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbXJYSEA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:04:00 -0400
Received: from [164.99.192.129] ([164.99.192.129])
	by jericho.provo.novell.com with ESMTP; Thu, 25 Oct 2007 12:03:44 -0600
In-Reply-To: <20071025163835.GB31888@fieldses.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62340>

On Thu, 2007-10-25 at 12:38 -0400, J. Bruce Fields wrote:

> It's definitely not a simple cut-and-paste--even with permission from
> the author of "Git for computer scientists", fitting this in would
> require rethinking the ordering of topics in the manual.

Oh, that can be done.  It's easier to move text around than to
rearchitect code :)

> Also, there's
> the restriction that we'd like to keep it looking good in plain ascii,
> so diagrams have to be done in ascii somehow.

Hmm, what's the rationale for this?  I'd assume that most people read
the user's manual as a web page (or as bedside reading if they can print
a PDF thereof), where diagrams can be pretty.

  Federico
