From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mention that git-rm can be an appropriate resolution as well as git-add.
Date: Fri, 30 Nov 2007 18:36:18 -0800
Message-ID: <7vr6i79m59.fsf@gitster.siamese.dyndns.org>
References: <11958251302874-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:36:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIDs-0003eS-9e
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758369AbXLACg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758367AbXLACg0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:36:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40258 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758324AbXLACgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:36:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 17F292F2;
	Fri, 30 Nov 2007 21:36:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id AC4DC9B9ED;
	Fri, 30 Nov 2007 21:36:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66678>

David Symonds <dsymonds@gmail.com> writes:

> Especially when using git-cherry-pick, removing files that are unmerged can be
> a logical action. This patch merely changes the informative text to be less
> confusing.
>
> Signed-off-by: David Symonds <dsymonds@gmail.com>

This would be a good wording change; I'll munge this for 'next'.

Thanks.
