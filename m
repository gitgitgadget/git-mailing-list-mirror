From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable threaded delta search on Mac OS X/Darwin
Date: Wed, 17 Dec 2008 22:02:36 -0800
Message-ID: <7vej06hvgj.fsf@gitster.siamese.dyndns.org>
References: <1229502025-15340-1-git-send-email-arjen@yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 07:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDBzQ-0000dk-C9
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 07:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbYLRGCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 01:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbYLRGCo
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 01:02:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYLRGCo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 01:02:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 569F688C34;
	Thu, 18 Dec 2008 01:02:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A208888C33; Thu,
 18 Dec 2008 01:02:38 -0500 (EST)
In-Reply-To: <1229502025-15340-1-git-send-email-arjen@yaph.org> (Arjen
 Laarhoven's message of "Wed, 17 Dec 2008 09:20:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7B7F694E-CCC9-11DD-8AA3-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103434>

I will apply this one, as I do not have an access to these machines and
there is no point for me to be holding onto it.  People who may be
affected, please test and report.
