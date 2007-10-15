From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-tag.txt: Document how to backdate
	tags
Date: Mon, 15 Oct 2007 16:35:23 -0400
Message-ID: <20071015203523.GA4428@sigill.intra.peff.net>
References: <87bqbklu5r.fsf@hariken.mwolson.org> <871wcglqrg.fsf@hariken.mwolson.org> <7vps00ivgh.fsf@gitster.siamese.dyndns.org> <87hclck6qy.fsf@hariken.mwolson.org> <7vd4w0iqd5.fsf@gitster.siamese.dyndns.org> <87lka4cllp.fsf@hariken.mwolson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 23:31:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhWf1-0003Gr-Me
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 22:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760719AbXJOUfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 16:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760573AbXJOUfY
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 16:35:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4384 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759604AbXJOUfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 16:35:24 -0400
Received: (qmail 24432 invoked by uid 111); 15 Oct 2007 20:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 15 Oct 2007 16:35:21 -0400
Received: (qmail 4489 invoked by uid 1000); 15 Oct 2007 20:35:23 -0000
Content-Disposition: inline
In-Reply-To: <87lka4cllp.fsf@hariken.mwolson.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61042>

On Mon, Oct 15, 2007 at 01:51:30PM -0400, Michael Olson wrote:

> +On Backdating Tags
> +~~~~~~~~~~~~~~~~~~
> +
> +If you have imported some changes from another VCS and would like
> +to add tags for major releases of you work, it is useful to be able

s/you/your/

-Peff
