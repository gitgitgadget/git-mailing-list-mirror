From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check_updates(): effective removal of cache entries
 marked CE_REMOVE
Date: Thu, 19 Feb 2009 23:41:25 -0800
Message-ID: <7vskm9ftcq.fsf@gitster.siamese.dyndns.org>
References: <1234995483-933-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri Feb 20 08:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQ2F-0008VO-Ni
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 08:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbZBTHlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 02:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbZBTHlb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 02:41:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbZBTHla (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 02:41:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DF87D2B85C;
	Fri, 20 Feb 2009 02:41:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 409272B856; Fri,
 20 Feb 2009 02:41:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E30419FE-FF21-11DD-B1A5-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110809>

I've queued this in 'next' as part of your earlier series, together with
the remaining patches..

I am also a bit surprised that it would make a noticeable difference in
real life.
