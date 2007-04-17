From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bisect: rename "t/t6030-bisect-run.sh" to "t/t6030-bisect-porcelain.sh".
Date: Mon, 16 Apr 2007 22:04:21 -0700
Message-ID: <7v3b2zsiay.fsf@assigned-by-dhcp.cox.net>
References: <20070417065148.69d06420.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 07:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdfrh-0002yd-6Z
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 07:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031088AbXDQFEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 01:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031089AbXDQFEY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 01:04:24 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62183 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031088AbXDQFEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 01:04:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417050423.PPYE1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Apr 2007 01:04:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o54N1W00L1kojtg0000000; Tue, 17 Apr 2007 01:04:22 -0400
In-Reply-To: <20070417065148.69d06420.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 17 Apr 2007 06:51:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44727>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  ...030-bisect-run.sh => t6030-bisect-porcelain.sh} |    0 
>  1 files changed, 0 insertions(+), 0 deletions(-)
>  rename t/{t6030-bisect-run.sh => t6030-bisect-porcelain.sh} (100%)
>
> diff --git a/t/t6030-bisect-run.sh b/t/t6030-bisect-porcelain.sh
> similarity index 100%
> rename from t/t6030-bisect-run.sh
> rename to t/t6030-bisect-porcelain.sh

Makes sense.  Thanks.
