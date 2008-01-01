From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git config problem with strange config files
Date: Tue, 01 Jan 2008 11:57:42 -0800
Message-ID: <7vir2d5nex.fsf@gitster.siamese.dyndns.org>
References: <200712311847.41499.kumbayo84@arcor.de>
	<20080101061734.GA15453@coredump.intra.peff.net>
	<20080101062314.GA21555@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Oberndorfer <kumbayo84@arcor.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 01 20:58:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9nG0-0003cs-J3
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 20:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbYAAT54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 14:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbYAAT54
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 14:57:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbYAAT5z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 14:57:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8658ACDF9;
	Tue,  1 Jan 2008 14:57:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DAC2CDF8;
	Tue,  1 Jan 2008 14:57:49 -0500 (EST)
In-Reply-To: <20080101062314.GA21555@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 1 Jan 2008 01:23:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69443>

I agree with your analysis, and thanks for the patch.
