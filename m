From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9600: allow testing with cvsps 2.2, including beta
	versions
Date: Wed, 16 Jul 2008 03:11:47 -0400
Message-ID: <20080716071147.GC4030@segfault.peff.net>
References: <20080715002019.5337.81984.stgit@dv.roinet.com> <7v1w1wdm37.fsf@gitster.siamese.dyndns.org> <20080714205114.cnwynr1q804wow4k-cebfxv@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 09:12:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ1By-0000Sa-CN
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 09:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbYGPHLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 03:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbYGPHLu
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 03:11:50 -0400
Received: from peff.net ([208.65.91.99]:3104 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763AbYGPHLt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 03:11:49 -0400
Received: (qmail 4979 invoked by uid 1000); 16 Jul 2008 07:11:47 -0000
Content-Disposition: inline
In-Reply-To: <20080714205114.cnwynr1q804wow4k-cebfxv@webmail.spamcop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88647>

On Mon, Jul 14, 2008 at 08:51:14PM -0400, Pavel Roskin wrote:

> > Excuse me, but we never assumed such.
> >
> > Neither too old nor too new ones are proven to work with us yet, so we
> > cannot be call them supported.
> 
> The message was "skipping cvsimport tests, cvsps too old" so the  
> assumption was there.

Heh, you can blame me for making that assumption. But at the time I
wrote it, I think cvsps development had stagnated, so there weren't new
versions. :)

-Peff
