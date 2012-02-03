From: "Neal Groothuis" <ngroot@lo-cal.org>
Subject: Re: Push from an SSH Terminal
Date: Fri, 3 Feb 2012 11:21:23 -0500 (EST)
Message-ID: <21607.38.96.167.131.1328286083.squirrel@mail.lo-cal.org>
References: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Feanil Patel" <feanil@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 17:21:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtLt9-00041r-NM
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 17:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab2BCQVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 11:21:23 -0500
Received: from dharma.lo-cal.org ([208.70.151.129]:47961 "EHLO
	dharma.lo-cal.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab2BCQVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 11:21:22 -0500
Received: from mail.lo-cal.org (localhost [127.0.0.1])
	by dharma.lo-cal.org (Postfix) with ESMTP id EADA82AEAB4;
	Fri,  3 Feb 2012 10:21:22 -0600 (CST)
Received: from 38.96.167.131
        (SquirrelMail authenticated user ngroot)
        by mail.lo-cal.org with HTTP;
        Fri, 3 Feb 2012 11:21:23 -0500 (EST)
In-Reply-To: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189782>

> The
> repository is password protected so if I'm physically at Comp B, I get
> a gui prompt for my username and password. However Comp A does not
> have X Forwarding setup to Comp B so I can't get the gui interface for
> the username and password when I try to do the push.  Is there an
> alternative way to provide my credentials when doing a git push that
> does not require a gui?

What protocol are you using to access the repository on Comp C?

- Neal
