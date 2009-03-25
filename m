From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: minor consistency fixes in
 git-difftool.txt.
Date: Wed, 25 Mar 2009 00:17:01 -0700
Message-ID: <7vocvq842a.fsf@gitster.siamese.dyndns.org>
References: <1237961655-29147-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 08:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmNOS-0007cu-6z
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 08:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772AbZCYHRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 03:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756715AbZCYHRJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 03:17:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507AbZCYHRI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 03:17:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 29FF994BB;
	Wed, 25 Mar 2009 03:17:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8D2B394BA; Wed,
 25 Mar 2009 03:17:03 -0400 (EDT)
In-Reply-To: <1237961655-29147-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Tue, 24 Mar 2009 23:14:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F2332D7A-190C-11DE-8CAD-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114573>

David Aguilar <davvid@gmail.com> writes:

> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  Documentation/git-difftool.txt |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index 5ae02f8..23070c1 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  'git-difftool' is a git command that allows you to compare and edit files
> -between revisions using common diff tools.  'git difftool' is a frontend
> +between revisions using common diff tools.  'git-difftool' is a frontend

I thought that the recent trend is to spell these as 'git difftool' (two
separate words), although I didn't follow the discussion on quoting styles
closely, so I do not know which of sq, dq or backtick is preferred.

Can somebody help me out here?
