From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Clean up find_unique_abbrev() callers
Date: Sun, 2 Mar 2008 02:51:53 -0500
Message-ID: <20080302075152.GA14843@coredump.intra.peff.net>
References: <7vpruf9q5a.fsf@gitster.siamese.dyndns.org> <20080301050641.GB8969@coredump.intra.peff.net> <7vy791sgzt.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:52:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVizo-0004C2-7V
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbYCBHv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbYCBHvz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:51:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4506 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbYCBHvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:51:55 -0500
Received: (qmail 5873 invoked by uid 111); 2 Mar 2008 07:51:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Mar 2008 02:51:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Mar 2008 02:51:53 -0500
Content-Disposition: inline
In-Reply-To: <7vy791sgzt.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75745>

On Sat, Mar 01, 2008 at 11:49:10PM -0800, Junio C Hamano wrote:

>  3 files changed, 3 insertions(+), 11 deletions(-)

I like it. :)

-Peff
