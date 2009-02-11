From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix the installation path for html documentation
Date: Wed, 11 Feb 2009 10:39:52 -0800
Message-ID: <7vr624es1z.fsf@gitster.siamese.dyndns.org>
References: <1234278853-25452-1-git-send-email-git@drmicha.warpmail.net>
 <200902102125.05287.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:42:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK25-0005RI-IG
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbZBKSkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755799AbZBKSkH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:40:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756501AbZBKSkC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:40:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F920980F2;
	Wed, 11 Feb 2009 13:39:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EB3E0980F0; Wed,
 11 Feb 2009 13:39:53 -0500 (EST)
In-Reply-To: <200902102125.05287.j6t@kdbg.org> (Johannes Sixt's message of
 "Tue, 10 Feb 2009 21:25:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 62DF66F0-F86B-11DD-A9F5-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109489>

Johannes Sixt <j6t@kdbg.org> writes:

> Makes sense. There is no point handling mandir and htmldir differently.

Thanks, both.
