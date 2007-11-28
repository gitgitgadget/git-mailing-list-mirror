From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Wed, 28 Nov 2007 14:48:15 -0800
Message-ID: <7vve7m2dhs.fsf@gitster.siamese.dyndns.org>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	<474AC136.8060906@viscovery.net>
	<451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
	<Pine.LNX.4.64.0711261340470.27959@racer.site>
	<97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
	<7vir3m94ku.fsf@gitster.siamese.dyndns.org>
	<50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
	<7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
	<1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
	<Pine.LNX.4.64.0711281355460.27959@racer.site>
	<474D7956.8050401@viscovery.net>
	<Pine.LNX.4.64.0711281428180.27959@racer.site>
	<474D7D92.2000106@viscovery.net>
	<7vr6ia5hoi.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711281903330.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVhz-0006nd-Ee
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899AbXK1WsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758026AbXK1WsY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:48:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59480 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757808AbXK1WsX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:48:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8709D2FB;
	Wed, 28 Nov 2007 17:48:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EBD8B9ACE4;
	Wed, 28 Nov 2007 17:48:38 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711281903330.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 28 Nov 2007 19:03:52 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66449>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Is there a particular reason to force linebreak when a semicolon would
>> do?
>
> D'oh.  Of course.  You want me to resend?

Semicolon I can handle but you seem to have local changes to filter
branch.
