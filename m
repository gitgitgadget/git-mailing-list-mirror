From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make a non-bare repo bare.
Date: Wed, 15 Jul 2009 19:33:40 -0700
Message-ID: <7vbpnlbbln.fsf@alter.siamese.dyndns.org>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 04:33:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRGn9-0005f3-Ck
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 04:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129AbZGPCdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 22:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757119AbZGPCdp
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 22:33:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757074AbZGPCdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 22:33:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FD78567D;
	Wed, 15 Jul 2009 22:33:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B0A1B567C; Wed,
 15 Jul 2009 22:33:41 -0400 (EDT)
In-Reply-To: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
 (Tim Visher's message of "Wed\, 15 Jul 2009 17\:43\:54 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14F5D838-71B1-11DE-8D54-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123356>

Tim Visher <tim.visher@gmail.com> writes:

> Hello Everyone,
>
> I recently had occasion to make a previously non-bare repo bare.  Is
> there any way to do this?  It will not allow me to delete a branch
> that I'm on so I wasn't sure how to proceed.

Funny.

    http://article.gmane.org/gmane.comp.version-control.git/123303

It is posed as a question but describes the correct (and officially
supported) procedure.
