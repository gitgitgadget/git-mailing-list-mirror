From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Tue, 01 Jul 2008 16:54:39 -0700
Message-ID: <7vskutkvnk.fsf@gitster.siamese.dyndns.org>
References: <20080701101114.GA6379@sigill.intra.peff.net>
 <1214912674-9443-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jul 02 01:56:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDpiD-0001AV-Jv
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 01:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbYGAXy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 19:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754944AbYGAXy4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 19:54:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbYGAXyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 19:54:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2426026746;
	Tue,  1 Jul 2008 19:54:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7838E26736; Tue,  1 Jul 2008 19:54:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A027542-47C9-11DD-A3ED-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87069>

Thomas Rast <trast@student.ethz.ch> writes:

> Jeff King wrote:
>> Now that this is in next, maybe it is a good time to repost the
>> add--interactive patch (it should be independent of Dscho's 2/2 "add -e"
>> patch).
>
> It is independent, so I suppose you're right.  (Dscho mentioned in
> passing he might repost "add -e" himself.)

Thanks, both.
