From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: use "spurious .sp" XSLT if
 DOCBOOK_SUPPRESS_SP is set
Date: Wed, 01 Apr 2009 22:25:01 -0700
Message-ID: <7veiwbk4pe.fsf@gitster.siamese.dyndns.org>
References: <7vljql4586.fsf@gitster.siamese.dyndns.org>
 <1238575834-17838-1-git-send-email-chris_johnsen@pobox.com>
 <20090401101400.GA26181@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Johnsen <chris_johnsen@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 07:27:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpFSG-00044C-Tg
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 07:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbZDBFZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 01:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbZDBFZN
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 01:25:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbZDBFZL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 01:25:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BA36A67C0;
	Thu,  2 Apr 2009 01:25:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 97EF7A67BF; Thu,
  2 Apr 2009 01:25:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A1D407D8-1F46-11DE-B537-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115442>

Jeff King <peff@peff.net> writes:

> I think the "feature knob" makes sense. I don't know that it is worth
> extensive testing with old releases. You have a pretty good guess about
> which versions are affected, and people who experience the problem can
> turn the knob. Your Makefile comments make it easy for them find the
> knob once they see the breakage.
>
> It is probably worth mentioning in the release notes to give a heads-up,
> though.

Thanks.
