From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Don't use PGP/GPG signatures in mail that contains patches
Date: Tue, 19 Jan 2016 21:05:47 +0000
Message-ID: <20160119210547.GA2822@dcvr.yhbt.net>
References: <569C3F73.3090805@pb.com>
 <20160118214857.GA24136@sigill.intra.peff.net>
 <569E2398.2050206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Andrey Utkin <andrey.od.utkin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:05:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLdTM-0000Kf-MM
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 22:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbcASVFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 16:05:49 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60540 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252AbcASVFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 16:05:48 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id E2D4C2014F;
	Tue, 19 Jan 2016 21:05:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <569E2398.2050206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284378>

Andrey Utkin <andrey.od.utkin@gmail.com> wrote:
> But still, if we encourage signing maillist correspondence, we would
> avoid impersonation attacks. Imagine that somebody sends stupid
> submissions from your name, maintainers shout at you, and your
> reputataion is... changed. Of course, you will be able to sort things
> out after you read the replies and reply that it's not you. But, given
> to openness of maillists, the attacker is able to follow your replies
> and insert his ones. Or to reply to your valid submissions that they are
> not from you.

Is impersonation an actual problem on vger.kernel.org lists?
Reply-to-all conventions on these lists do a great deal to discourage them.
