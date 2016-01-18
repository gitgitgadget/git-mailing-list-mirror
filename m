From: Eric Wong <normalperson@yhbt.net>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Mon, 18 Jan 2016 21:39:57 +0000
Message-ID: <20160118213957.GA25460@dcvr.yhbt.net>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
 <569CEA1C.90700@drmicha.warpmail.net>
 <20160118170655.GA24184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 22:40:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLHWs-0003ty-4b
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 22:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600AbcARVj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 16:39:59 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:37745 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530AbcARVj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 16:39:57 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 5DE22633810;
	Mon, 18 Jan 2016 21:39:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160118170655.GA24184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284325>

Jeff King <peff@peff.net> wrote:
> On Mon, Jan 18, 2016 at 02:35:24PM +0100, Michael J Gruber wrote:
> > Junio C Hamano venit, vidit, dixit 12.01.2016 00:45:
> > > 
> > > * mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits

> > >  Will discard.
> > 
> > Oh, sorry. Work killing me plus I was waiting for help, too.
> 
> FWIW, I took a look at them a few months ago, but I couldn't reproduce
> the problems in the first place. I think it has to do with the default
> apache setup given by my system (debian unstable) versus others.

Ugh, I was meaning to look into these too (after upgrading to
Debian Jessie), but maybe it needs to be tested on Fedora/RH-based
configs?
