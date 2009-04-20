From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] fetch: Strip usernames from url's before storing them
Date: Mon, 20 Apr 2009 01:36:30 -0700
Message-ID: <7vvdozk9gx.fsf@gitster.siamese.dyndns.org>
References: <7vbpqxvnpl.fsf@gitster.siamese.dyndns.org>
 <1239956411-11195-1-git-send-email-ae@op5.se> <49EC26BC.5070505@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Apr 20 10:38:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvp1B-0007eO-GW
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 10:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbZDTIgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 04:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753156AbZDTIgk
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 04:36:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbZDTIgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 04:36:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C0B810386;
	Mon, 20 Apr 2009 04:36:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8BAE810385; Mon,
 20 Apr 2009 04:36:32 -0400 (EDT)
In-Reply-To: <49EC26BC.5070505@op5.se> (Andreas Ericsson's message of "Mon,
 20 Apr 2009 09:39:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B8058EC-2D86-11DE-867B-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116949>

Andreas Ericsson <ae@op5.se> writes:

> We've used this patch in production the past couple of days.
> All tests pass and it works just fine. Any issues with it I
> should fix, or did it just slip through?

The latter, and a bit of my slowing down on handling new feature patches
during the pre-release freeze.

Will queue.
