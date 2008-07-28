From: Junio C Hamano <gitster@pobox.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
 custom merge strategy
Date: Mon, 28 Jul 2008 13:07:33 -0700
Message-ID: <7vproxrcvu.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
 <20080728185604.GA26322@sigill.intra.peff.net>
 <alpine.DEB.1.00.0807282008470.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, sverre@rabbelier.nl,
	Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNZ1P-0006oa-5e
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbYG1UHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbYG1UHn
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:07:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbYG1UHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:07:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F8C3482A5;
	Mon, 28 Jul 2008 16:07:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A1B9A482A4; Mon, 28 Jul 2008 16:07:35 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807282008470.8986@racer> (Johannes
 Schindelin's message of "Mon, 28 Jul 2008 20:09:55 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D5682346-5CE0-11DD-8913-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90497>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Well, I have to say that the workflow is a bit backwards if the person who 
> _publishes_ the thing is the one saying "Ooops, my version no goodie, 
> other version please, but so that pull still works".
>
> I would have expected the one who has the good version to make the choice.

That reminds me of:

    http://thread.gmane.org/gmane.comp.version-control.git/89178

to one of whose messages I sent a response today.
