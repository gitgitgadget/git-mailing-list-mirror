From: Thomas Quinot <thomas@quinot.org>
Subject: Re: [PATCH v4] git_connect: set ssh shell command in GIT_SSH_COMMAND
Date: Mon, 10 Nov 2014 09:28:58 +0100
Message-ID: <20141110082858.GA71642@melamine.cuivre.fr.eu.org>
References: <20141108110958.GB20750@peff.net>
 <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
 <20141108142753.GA28652@melamine.cuivre.fr.eu.org>
 <20141109095155.GB17369@peff.net>
 <20141109123934.GA50956@melamine.cuivre.fr.eu.org>
 <xmqq389se0up.fsf@gitster.dls.corp.google.com>
 <20141109174738.GA58680@melamine.cuivre.fr.eu.org>
 <xmqqppcwb6ip.fsf@gitster.dls.corp.google.com>
 <20141109224231.GA59064@melamine.cuivre.fr.eu.org>
 <20141110071154.GD7677@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 09:29:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnkLY-0005hq-UM
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 09:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbaKJI3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 03:29:08 -0500
Received: from houdart.cuivre.fr.eu.org ([81.57.40.110]:22269 "EHLO
	melamine.cuivre.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaKJI3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 03:29:07 -0500
Received: by melamine.cuivre.fr.eu.org (Postfix, from userid 1000)
	id 9B6EB326B4; Mon, 10 Nov 2014 09:28:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141110071154.GD7677@peff.net>
X-message-flag: WARNING! Using Outlook can damage your computer.
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Jeff King, 2014-11-10 :

> I think this version looks good. Thanks for working on it.

Thanks!

> Two style micro-nits (that I do not think even merit a re-roll by
> themselves, but Junio may want to mark up as he applies):

OK, committed locally, I can resend a PATCH v5 if that's more
convenient -- do let me know.

Thomas.
