From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2008, #03; Sun, 21)
Date: Tue, 23 Dec 2008 07:05:35 -0500
Message-ID: <20081223120534.GA21633@coredump.intra.peff.net>
References: <7vr641pvid.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 13:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF62L-00078U-KQ
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 13:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbYLWMFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 07:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbYLWMFi
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 07:05:38 -0500
Received: from peff.net ([208.65.91.99]:1456 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbYLWMFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 07:05:38 -0500
Received: (qmail 16030 invoked by uid 111); 23 Dec 2008 12:05:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 23 Dec 2008 07:05:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2008 07:05:35 -0500
Content-Disposition: inline
In-Reply-To: <7vr641pvid.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103811>

On Sun, Dec 21, 2008 at 04:23:22AM -0800, Junio C Hamano wrote:

> * js/notes (Sat Dec 20 13:06:03 2008 +0100) 4 commits
>  - Add an expensive test for git-notes
>  - Speed up git notes lookup
>  - Add a script to edit/inspect notes
>  - Introduce commit notes

I haven't had much time to really look at this closely, and I probably
won't for another week or so due to the holidays. But from my cursory
examination, I think I want to propose something that is a bit
different. So if nobody objects (and I think Dscho already said he was
going to be out of touch for two weeks due to the holidays) I'd like
this to remain in pu for the time being.

-Peff
