From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-submodule: add "sync" command
Date: Wed, 27 Aug 2008 10:39:27 -0700
Message-ID: <7vabeyqrw0.fsf@gitster.siamese.dyndns.org>
References: <20080827084302.GB1422@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:40:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYP0c-00087r-4Q
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 19:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbYH0Rjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbYH0Rje
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 13:39:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbYH0Rje (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 13:39:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 774E062B72;
	Wed, 27 Aug 2008 13:39:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9016462B71; Wed, 27 Aug 2008 13:39:29 -0400 (EDT)
In-Reply-To: <20080827084302.GB1422@gmail.com> (David Aguilar's message of
 "Wed, 27 Aug 2008 01:43:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1C3258D8-745F-11DD-8D0F-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93908>

David Aguilar <davvid@gmail.com> writes:

> I'm just checking up on the status of this patch:
> http://thread.gmane.org/gmane.comp.version-control.git/93535/focus=93557
>
> I believe v3 addressed all of your comments from that thread.
> Let me know if there's anything else I should consider.

I didn't find anything wrong in there and already have a topic for it, but
ran out of time merging it to even 'pu' last night which was not my git
day.

Will most likely appear in 'next' by the end of today, but no promises.
