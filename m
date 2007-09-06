From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/9] Add strbuf_printf() to do formatted printing to a strbuf.
Date: Thu, 06 Sep 2007 01:55:26 -0700
Message-ID: <7vwsv4b2bl.fsf@gitster.siamese.dyndns.org>
References: <11890382183913-git-send-email-krh@redhat.com>
	<11890382242333-git-send-email-krh@redhat.com>
	<11890382243290-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 10:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITD9E-0004WE-2d
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 10:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbXIFIzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 04:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546AbXIFIzb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 04:55:31 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbXIFIzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 04:55:31 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0536412F534;
	Thu,  6 Sep 2007 04:55:49 -0400 (EDT)
In-Reply-To: <11890382243290-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Wed, 5 Sep 2007 20:23:32 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57844>

As you noted in your follow-up message, this one has overlaps
with the other strbuf series.  I could adjust them if I wanted
to, but I do not have time for it right now.  I might try over
the weekend but no promises.
