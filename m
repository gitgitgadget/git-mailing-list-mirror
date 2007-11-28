From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add basic cvsimport tests
Date: Wed, 28 Nov 2007 14:14:07 -0800
Message-ID: <7v8x4i3tn4.fsf@gitster.siamese.dyndns.org>
References: <20071128185504.GA11236@coredump.intra.peff.net>
	<20071128185546.GA11320@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:14:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVB2-00020H-RZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539AbXK1WOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757164AbXK1WOO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:14:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60123 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757490AbXK1WON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:14:13 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9424A2EF;
	Wed, 28 Nov 2007 17:14:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 226BB9ACBA;
	Wed, 28 Nov 2007 17:14:31 -0500 (EST)
In-Reply-To: <20071128185546.GA11320@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Nov 2007 13:55:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66440>

Jeff King <peff@peff.net> writes:

> +	cat <<EOF >o_fortuna &&
> +O Fortuna
> + ...

Copyrights?

> +add "O Fortuna" lyrics
> +
> +These public domain lyrics make an excellent sample text.
> +EOF

Ah, really?  Ok... 
