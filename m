From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: update Japanese translation
Date: Sun, 03 Aug 2008 14:24:18 -0700
Message-ID: <7vy73dssfx.fsf@gitster.siamese.dyndns.org>
References: <20080803170150.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 23:25:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPl52-0003fL-Lw
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 23:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbYHCVY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 17:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756664AbYHCVY1
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 17:24:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbYHCVY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 17:24:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E349349F13;
	Sun,  3 Aug 2008 17:24:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0ABB249F12; Sun,  3 Aug 2008 17:24:21 -0400 (EDT)
In-Reply-To: <20080803170150.6117@nanako3.lavabit.com> (nanako3@lavabit.com's
 message of "Sun, 3 Aug 2008 17:01:50 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C6818A6-61A2-11DD-82D4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91274>

しらいしななこ  <nanako3@lavabit.com> writes:

> This updates Japanese translation to match the updated git-gui.pot.
>
> Signed-off-by: しらいしななこ <nanako3@lavabit.com>

Looks fine to me, thanks.

>  ...
> -#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.sh:744
> -#: git-gui.sh:763
> +#: git-gui.sh:41 git-gui.sh:688 git-gui.sh:702 git-gui.sh:715 git-gui.sh:798
> +#: git-gui.sh:817

It makes me wonder if we can do something about these line number changes
appearing on the patch, though...

Yes, I know it is a useful piece of information for PO aware editors to
help translators, but still...
