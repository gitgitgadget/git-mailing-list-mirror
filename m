From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Abort with an error if 'fetch' parameter is
 invalid.
Date: Sun, 03 Aug 2008 17:21:37 -0700
Message-ID: <7viquh7hpq.fsf@gitster.siamese.dyndns.org>
References: <1217451235-9609-1-git-send-email-apenwarr@gmail.com>
 <20080804000140.GA13019@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 02:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPnqa-0002jN-BU
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 02:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbYHDAVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbYHDAVp
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 20:21:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbYHDAVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 20:21:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77B2648F30;
	Sun,  3 Aug 2008 20:21:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F25E248F2F; Sun,  3 Aug 2008 20:21:39 -0400 (EDT)
In-Reply-To: <20080804000140.GA13019@untitled> (Eric Wong's message of "Sun,
 3 Aug 2008 17:01:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50E27592-61BB-11DD-A3D9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91297>

Eric Wong <normalperson@yhbt.net> writes:

>> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
>
> Thanks Avery,
> Acked-by: Eric Wong <normalperson@yhbt.net>

I do not seem to find the original message in mbox nor list archive, by
the way...
