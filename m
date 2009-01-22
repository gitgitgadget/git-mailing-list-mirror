From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #05; Wed, 21)
Date: Wed, 21 Jan 2009 23:26:43 -0500
Message-ID: <20090122042643.GB31427@coredump.intra.peff.net>
References: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 05:28:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPrAu-0005be-6X
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 05:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbZAVE0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 23:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756519AbZAVE0q
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 23:26:46 -0500
Received: from peff.net ([208.65.91.99]:45052 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755639AbZAVE0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 23:26:45 -0500
Received: (qmail 23910 invoked by uid 107); 22 Jan 2009 04:26:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Jan 2009 23:26:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 23:26:43 -0500
Content-Disposition: inline
In-Reply-To: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106717>

On Wed, Jan 21, 2009 at 07:55:36PM -0800, Junio C Hamano wrote:

> * jk/signal-cleanup (Sun Jan 11 06:36:49 2009 -0500) 3 commits
>  - pager: do wait_for_pager on signal death
>  - refactor signal handling for cleanup functions
>  - chain kill signals for cleanup functions
> 
> I think this can move to 'next', as Peff and J6t agreed on how to fix
> things up as needed for Windows.

Please wait for my re-roll, which I'll send in a few minutes.

-Peff
