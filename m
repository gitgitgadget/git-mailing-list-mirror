From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svnimport: added explicit merge graph option -G
Date: Sun, 24 Jun 2007 15:17:05 -0700
Message-ID: <7vd4zlq9pa.fsf@assigned-by-dhcp.cox.net>
References: <49428.47661.qm@web43139.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Peter Baumann <waste.manager@gmx.de>
To: Stas Maximov <smaximov@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 00:17:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2aOR-0002ko-Cf
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbXFXWRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 18:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbXFXWRK
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:17:10 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35710 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbXFXWRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 18:17:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624221707.HJBY3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Jun 2007 18:17:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FaH51X0021kojtg0000000; Sun, 24 Jun 2007 18:17:05 -0400
In-Reply-To: <49428.47661.qm@web43139.mail.sp1.yahoo.com> (Stas Maximov's
	message of "Sun, 24 Jun 2007 14:48:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50827>

Stas Maximov <smaximov@yahoo.com> writes:

> Attached are two patches:
>
> 1. resubmission of the original patch with proper sign-off; and 
> 2. patch with permissions fix (thanks to Alex Reisen for pointing out);

As you are assuming that the original patch was rejected (by
resending that as the first one here), I do not think these
changes should be in two separate commits.  Please redo them as
a single patch.

Also please do not "Attach".  When you have N patches to send,
send N e-mail messages, numbered from [PATCH 1/N] to [PATCH
N/N], each with one patch in the message itself.

Please see Documentation/SubmittingPatches.
