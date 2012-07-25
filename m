From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Teach Makefile.PL to find .pm files on its own
Date: Wed, 25 Jul 2012 23:37:56 +0000
Message-ID: <20120725233755.GA9036@dcvr.yhbt.net>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <7vhasvdbk9.fsf@alter.siamese.dyndns.org>
 <5010567B.1060907@pobox.com>
 <7vehnzbmyt.fsf@alter.siamese.dyndns.org>
 <50106136.5000404@pobox.com>
 <7vsjcfa3ha.fsf@alter.siamese.dyndns.org>
 <5010798E.6020401@pobox.com>
 <7vk3xra07x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:38:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuB9W-0004Xx-Qk
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 01:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab2GYXh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 19:37:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40341 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab2GYXh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 19:37:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657681F439;
	Wed, 25 Jul 2012 23:37:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vk3xra07x.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202216>

Junio C Hamano <gitster@pobox.com> wrote:
> Michael G Schwern <schwern@pobox.com> writes:
> > So... is that master or maint?  Just let me know which one.
> 
> I do not care too deeply either way, and in the end I think Eric
> should have the final say.
> 
> Given that git://git.bogomips.org/git-svn.git/ has 'master' but
> nothing to build on 'maint', I would imagine that basing on master
> is just fine.

Yes, "master" is fine.
