From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-merge hook and related tests
Date: Tue, 25 Sep 2007 16:21:49 -0700
Message-ID: <7vr6km2uwi.fsf@gitster.siamese.dyndns.org>
References: <1190760563-32453-1-git-send-email-jjengla@sandia.gov>
	<1190760563-32453-2-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:22:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJj8-0005nx-B4
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 01:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbXIYXVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 19:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbXIYXVy
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 19:21:54 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbXIYXVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 19:21:54 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FBC013BBCF;
	Tue, 25 Sep 2007 19:22:13 -0400 (EDT)
In-Reply-To: <1190760563-32453-2-git-send-email-jjengla@sandia.gov> (Josh
	England's message of "Tue, 25 Sep 2007 16:49:22 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59193>

"Josh England" <jjengla@sandia.gov> writes:

> Signed-off-by: Josh England <jjengla@sandia.gov>
> ---
>  git-merge.sh               |   13 ++++++++++
>  t/t5402-post-merge-hook.sh |   56 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 0 deletions(-)
>  create mode 100644 t/t5402-post-merge-hook.sh

I think this is part of the 'master' for at least a few days, so
is a half of the Documentation patch.
