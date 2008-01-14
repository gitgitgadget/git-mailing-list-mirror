From: Junio C Hamano <gitster@pobox.com>
Subject: Re: format-patch usage
Date: Sun, 13 Jan 2008 17:02:11 -0800
Message-ID: <7vmyr9nrsc.fsf@gitster.siamese.dyndns.org>
References: <1200270370-sup-4560@south>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: William Morgan <wmorgan-git@masanjin.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 02:03:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEDjB-0001d0-T8
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 02:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbYANBCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 20:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYANBCe
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 20:02:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbYANBCd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 20:02:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B56A3451C;
	Sun, 13 Jan 2008 20:02:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 60C67451B;
	Sun, 13 Jan 2008 20:02:28 -0500 (EST)
In-Reply-To: <1200270370-sup-4560@south> (William Morgan's message of "Sun, 13
	Jan 2008 16:40:17 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70431>

William Morgan <wmorgan-git@masanjin.net> writes:

> Two questions from a git neophyte about using format-patch:

Both come from the established kernel Documentation/SubmittingPatches
convention.
