From: Junio C Hamano <gitster@pobox.com>
Subject: Re: va_copy is not available on all systems.
Date: Mon, 20 Aug 2007 21:53:06 -0700
Message-ID: <7vabslpjyl.fsf@gitster.siamese.dyndns.org>
References: <46C99448.2AB33DFF@eudaptics.com>
	<20070820191509.GB5544@steel.home>
	<20070821033813.GF27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 06:53:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INLkC-0004yL-Jk
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 06:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbXHUExO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 00:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbXHUExO
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 00:53:14 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbXHUExN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 00:53:13 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 17E5C12404F;
	Tue, 21 Aug 2007 00:53:29 -0400 (EDT)
In-Reply-To: <20070821033813.GF27913@spearce.org> (Shawn O. Pearce's message
	of "Mon, 20 Aug 2007 23:38:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56276>

Thanks, I think the patch makes sense.
