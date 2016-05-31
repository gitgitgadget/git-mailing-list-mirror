From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 31 May 2016 18:23:22 -0400
Message-ID: <20160531222322.GC3824@sigill.intra.peff.net>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com>
 <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:23:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7s4Q-0005UH-J5
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbcEaWX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 18:23:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:46789 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752788AbcEaWX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:23:26 -0400
Received: (qmail 1241 invoked by uid 102); 31 May 2016 22:23:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:23:26 -0400
Received: (qmail 27847 invoked by uid 107); 31 May 2016 22:23:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:23:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 18:23:22 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296023>

On Tue, May 31, 2016 at 07:43:27PM +0700, Duy Nguyen wrote:

> > [3] http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020
> 
> This points to  https://github.com/peff/git/commits/jk/external-odb
> which is dead. Jeff, do you still have it somewhere, or is it not
> worth looking at anymore?

It's now "jk/external-odb-wip" at the same repo. I wouldn't be surprised
if it doesn't even compile, though. I basically rebase my topics daily
against Junio's "master", so it may be carried forward, but things
marked "-wip" aren't part of my daily git build, and generally don't
even get compile-tested (usually if the rebase looks too hairy or awful,
I'll drop it completely, though, and I haven't done that here).

You're probably better off looking whatever Christian produces. :)

-Peff
