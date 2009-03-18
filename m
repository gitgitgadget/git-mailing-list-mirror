From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Documentation: reworded the "Description" section of
 git-blame.txt.
Date: Tue, 17 Mar 2009 22:41:05 -0700
Message-ID: <7vtz5rmlqm.fsf@gitster.siamese.dyndns.org>
References: <1237270577-17261-1-git-send-email-dmellor@whistlingcat.com>
 <1237270577-17261-2-git-send-email-dmellor@whistlingcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David J. Mellor" <dmellor@whistlingcat.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 06:42:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjoYK-0001Rj-AB
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 06:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbZCRFlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 01:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbZCRFlO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 01:41:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbZCRFlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 01:41:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 18A56A2E4B;
	Wed, 18 Mar 2009 01:41:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 26881A2E4A; Wed,
 18 Mar 2009 01:41:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 626D124C-137F-11DE-AF4A-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113576>

"David J. Mellor" <dmellor@whistlingcat.com> writes:

> Reworded this section to make it less chatty. Also made minor grammatical
> fixes.
>
> Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
> ---
>  Documentation/git-bisect.txt |  154 +++++++++++++++++++++---------------------
>  1 files changed, 77 insertions(+), 77 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index e65c1ca..df0ed36 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -48,61 +49,62 @@ $ git bisect good v2.6.13-rc2    # v2.6.13-rc2 was the last version
> ...
>  ------------------------------------------------
>  $ git bisect reset
>  ------------------------------------------------
>  
> -to get back to the original branch, instead of being on the bisection
> -commit ("git bisect start" will do that for you too, actually: it will
> -reset the bisection state).
> +This resest the tree to the original branch instead of being on the

This "resets" the tree.

Otherwise looked fine; thanks.
