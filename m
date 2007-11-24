From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] core.whitespace: documentation updates.
Date: Sat, 24 Nov 2007 13:42:46 -0800
Message-ID: <7v3auvqq09.fsf@gitster.siamese.dyndns.org>
References: <7v8x4os223.fsf@gitster.siamese.dyndns.org>
	<7v4pfcs20b.fsf@gitster.siamese.dyndns.org>
	<7v7ik7quc6.fsf_-_@gitster.siamese.dyndns.org>
	<20071124202257.GC12864@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Nov 24 22:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iw2mM-00074n-65
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 22:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbXKXVmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 16:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbXKXVmv
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 16:42:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49298 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbXKXVmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 16:42:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 14D192EF;
	Sat, 24 Nov 2007 16:43:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B3A4A99310;
	Sat, 24 Nov 2007 16:43:09 -0500 (EST)
In-Reply-To: <20071124202257.GC12864@fieldses.org> (J. Bruce Fields's message
	of "Sat, 24 Nov 2007 15:22:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65962>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> I'd still prefer this to be a gitattributes thing rather than a config
> variable[1].  Last time I raised this you said something to the effect
> of "I think you're right, let's fix that before it's merged."  Would you
> like me to work on that?

Ah, I forgot about that, and you are right.  Go wild.
