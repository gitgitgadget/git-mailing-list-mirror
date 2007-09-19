From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Latest builtin-commit series
Date: Wed, 19 Sep 2007 16:16:55 -0700
Message-ID: <7v1wcup7o8.fsf@gitster.siamese.dyndns.org>
References: <1190129009.23692.24.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY8nE-0004YB-U4
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 01:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbXISXRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 19:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbXISXRF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 19:17:05 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:58758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621AbXISXRE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 19:17:04 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7954E1384A2;
	Wed, 19 Sep 2007 19:17:21 -0400 (EDT)
In-Reply-To: <1190129009.23692.24.camel@hinata.boston.redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Tue, 18 Sep 2007 11:23:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58742>

This series somewhat collided with Pierre's strbuf clean-ups.  I
queued it in 'pu' for now after fixing the conflicts up.

I haven't looked at the code enough to give any meaningful
comments yet, but I agree with most of the comments Dscho and
others raised on the topic already.
