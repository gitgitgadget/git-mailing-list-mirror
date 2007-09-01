From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] URL: allow port specification in ssh:// URLs
Date: Sat, 01 Sep 2007 03:15:37 -0700
Message-ID: <7v1wdiu1x2.fsf@gitster.siamese.dyndns.org>
References: <583261.77513.qm@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Sat Sep 01 12:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRQ13-0008Oz-V8
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 12:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbXIAKPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 06:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbXIAKPl
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 06:15:41 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbXIAKPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 06:15:41 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EBF8212C3FE;
	Sat,  1 Sep 2007 06:16:00 -0400 (EDT)
In-Reply-To: <583261.77513.qm@web31802.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Sat, 1 Sep 2007 02:36:31 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57266>

Nicely done.

Although none of this may be strictly necessary (you can always
add entries to ~/.ssh/config), people often got confused because
we did not support this syntax.

Thanks.
