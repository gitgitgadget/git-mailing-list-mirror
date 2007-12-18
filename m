From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git show <tag>: show the tagger
Date: Tue, 18 Dec 2007 12:10:19 -0800
Message-ID: <7vfxxzzrv8.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712181800250.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:11:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4imZ-0003iC-LQ
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbXLRUKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXLRUKg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:10:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbXLRUKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:10:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 79F055330;
	Tue, 18 Dec 2007 15:10:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 92DFD532A;
	Tue, 18 Dec 2007 15:10:26 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712181800250.23902@racer.site> (Johannes
	Schindelin's message of "Tue, 18 Dec 2007 18:01:33 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68801>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For commit objects, the Author is shown, so do the equivalent for
> tag objects, too.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	I know, it's feature freeze period.  But this is arguably a 
> 	usability bug.

I'll wait for people to argue this fixes a usability bug, then.
