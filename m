From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Friendly refspecs
Date: Wed, 09 Apr 2008 14:21:16 -0700
Message-ID: <7vabk23esz.fsf@gitster.siamese.dyndns.org>
References: <20080409101428.GA2637@elte.hu>
 <20080409145758.GB20874@sigill.intra.peff.net>
 <20080409200836.GA19248@mithlond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Apr 09 23:22:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjhkZ-00042E-Qz
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 23:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000AbYDIVVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 17:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755997AbYDIVVj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 17:21:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbYDIVVj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 17:21:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A68D5998;
	Wed,  9 Apr 2008 17:21:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 33CA23365; Wed,  9 Apr 2008 17:21:23 -0400 (EDT)
In-Reply-To: <20080409200836.GA19248@mithlond> (Teemu Likonen's message of
 "Wed, 9 Apr 2008 23:08:36 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79138>

Teemu Likonen <tlikonen@iki.fi> writes:

[By the way, please never redirect the response to your messages away from
you with:

    Mail-Followup-To: Jeff King <peff@peff.net>, Ingo Molnar <mingo@elte.hu>,
            git@vger.kernel.org

You wasted 30 seconds of my (and anybody who potentially wanted to give
advice to you) time by forcing me fix the To: header while composing this
response.  I know Jeff understands what I am going to mention, and I do
not want to waste his time by putting him on To: header.]

> Currently "git fetch <URL>" does not seem to do anything useful for
> non-git-hackers. It seems to fetch objects but not create any branches
> referring to them.

I'd suggest you to study:

  http://thread.gmane.org/gmane.comp.version-control.git/31351/focus=31634

Not everybody wants remote tracking.
