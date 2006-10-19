From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 11:13:19 -0500
Message-ID: <20061019161319.GA75501@over-yonder.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 18:13:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaaWY-00045F-IJ
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 18:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946173AbWJSQNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 12:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946176AbWJSQNV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 12:13:21 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:56045 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1946173AbWJSQNU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 12:13:20 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id B6DB92842A;
	Thu, 19 Oct 2006 11:13:19 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id 32F5C61C52; Thu, 19 Oct 2006 11:13:19 -0500 (CDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29366>

On Thu, Oct 19, 2006 at 08:25:26AM -0700 I heard the voice of
Linus Torvalds, and lo! it spake thus:
> 
> The biggest difference seems to be that in bzr, the final checksum
> is 64-bit,

Actually, as best I know, it's not a checksum, just random bits (a
quick glance at the code seems to agree with me).


> Note that from a usability standpoint, the UUID's look more readable
> to a human, but are actually much worse [...]

This I agree with, at least in part.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
