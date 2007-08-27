From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change options to alphabetical order
Date: Mon, 27 Aug 2007 01:16:38 -0700
Message-ID: <7vps19l7dl.fsf@gitster.siamese.dyndns.org>
References: <6431frn5.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:16:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPZm9-0008Qo-Lx
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbXH0IQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbXH0IQm
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:16:42 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXH0IQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:16:41 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E65E1292BD;
	Mon, 27 Aug 2007 04:17:01 -0400 (EDT)
In-Reply-To: <6431frn5.fsf@cante.net> (Jari Aalto's message of "Mon, 27 Aug
	2007 08:55:26 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56776>

This might make sense but I do not want a patch only to git-tag
and I certainly do not want it right now.

If it makes sense to reorder in alphabetical order, we would
want to do so for everybody at once.
