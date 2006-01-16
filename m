From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb: latest blob date (request)
Date: Mon, 16 Jan 2006 18:44:44 +0100
Message-ID: <20060116174444.GA13512@vrfy.org>
References: <20060115173100.1134256b.rdunlap@xenotime.net> <17355.10749.834774.642712@cargo.ozlabs.ibm.com> <20060115211011.17b18f60.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 18:45:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyYPc-0001Qm-T9
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 18:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWAPRoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 12:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWAPRoz
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 12:44:55 -0500
Received: from soundwarez.org ([217.160.171.123]:48021 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750744AbWAPRoy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 12:44:54 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id B0F4D7BFEF; Mon, 16 Jan 2006 18:44:44 +0100 (CET)
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Content-Disposition: inline
In-Reply-To: <20060115211011.17b18f60.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14747>

On Sun, Jan 15, 2006 at 09:10:11PM -0800, Randy.Dunlap wrote:
> On Mon, 16 Jan 2006 16:07:09 +1100 Paul Mackerras wrote:
> 
> > Randy,
> > 
> > > I would find it helpful (a user optimization) if each tree list
> > > contained a date-last-modified/updated.  This could be used
> > > to help decide if I (someone) wanted to click on a particular
> > > blob or history (OK, blobs are quick, but history can be
> > > very time-consuming, so being able to shortcut or skip
> > > history would be very helpful IMO).
> > 
> > Are you talking about gitk or gitweb?  If you mean gitweb on
> > kernel.org, Kay Sievers is who you need to talk to.
> 
> Sheesh, you are correct.  Sorry.

Hmm, where do I find this information? It is recorded in last commit,
that changed the file, right? I'm not sure, if we can get this out of
the git tools?

Thanks,
Kay
