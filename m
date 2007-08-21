From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the -p option for git-show.
Date: Tue, 21 Aug 2007 10:33:42 -0700
Message-ID: <7v1wdwpzbd.fsf@gitster.siamese.dyndns.org>
References: <20070821124949.GH768@genesis.frugalware.org>
	<200708211901.55687.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXc7-0003kk-CV
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482AbXHURd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755997AbXHURd4
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:33:56 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbXHURdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 13:33:55 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A66F01259B2;
	Tue, 21 Aug 2007 13:34:10 -0400 (EDT)
In-Reply-To: <200708211901.55687.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Tue, 21 Aug 2007 19:01:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56311>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> How about this instead:
>
> -- robin
>
> Include diff options into git-show command manual

I think that is probably a good idea but I wonder if placing
diff-options in between of pretty-options and pretty-formats is
a good idea.
