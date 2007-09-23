From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email is omitting author and date lines
Date: Sun, 23 Sep 2007 16:29:03 -0700
Message-ID: <7v4phlc668.fsf@gitster.siamese.dyndns.org>
References: <1190585633.29937.44.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hanspeter Kunz <hp@edelkunz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 24 01:30:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZau0-0001vm-Mo
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 01:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXIWX3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 19:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbXIWX3J
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 19:29:09 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbXIWX3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 19:29:08 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 281E413AA5D;
	Sun, 23 Sep 2007 19:29:27 -0400 (EDT)
In-Reply-To: <1190585633.29937.44.camel@localhost> (Hanspeter Kunz's message
	of "Mon, 24 Sep 2007 00:13:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59001>

Hanspeter Kunz <hp@edelkunz.ch> writes:

> When sending a patch to myself using `git-send-email` I realized that
> the lines containing the author and the date (lines 5 and 6 in the patch
> file) were not in the sent email.

Was the commit authored by yourself?
