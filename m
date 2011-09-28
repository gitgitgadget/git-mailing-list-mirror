From: Peter Stuge <peter@stuge.se>
Subject: Re: [PATCH] gitweb: Fix links to lines in blobs when
	javascript-actions are enabled
Date: Wed, 28 Sep 2011 03:31:01 +0200
Message-ID: <20110928013101.9699.qmail@stuge.se>
References: <20110927094947.10955.qmail@stuge.se> <1317117060-3955-1-git-send-email-peter@stuge.se> <7v7h4tykf3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 03:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8izU-0007fr-Nt
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 03:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab1I1BbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 21:31:08 -0400
Received: from foo.stuge.se ([212.116.89.98]:33746 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751313Ab1I1BbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 21:31:07 -0400
Received: (qmail 9700 invoked by uid 501); 28 Sep 2011 01:31:01 -0000
Content-Disposition: inline
In-Reply-To: <7v7h4tykf3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182284>

Junio C Hamano wrote:
> Nicely done.

Thanks.

> You forgot to mention another bug you fixed

Well.. I'm not sure that it is worth mentioning, since it may never
actually have been triggered by the way fixLinks() works.


> I'll amend in a few sentences to describe it as well.

Go for it.


//Peter
