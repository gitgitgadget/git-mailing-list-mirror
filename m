From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Character set for the HTML documentation
Date: Tue, 17 Jul 2007 19:02:15 -0700
Message-ID: <7vd4yqa2qg.fsf@assigned-by-dhcp.cox.net>
References: <469D516B.6030806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 04:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAys2-0008Fl-Td
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 04:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbXGRCCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 22:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbXGRCCR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 22:02:17 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39433 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbXGRCCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 22:02:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718020215.KZHB1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Jul 2007 22:02:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Qq2F1X00L1kojtg0000000; Tue, 17 Jul 2007 22:02:16 -0400
In-Reply-To: <469D516B.6030806@zytor.com> (H. Peter Anvin's message of "Tue,
	17 Jul 2007 16:31:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52819>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Can we switch the documentation over to UTF-8, this is 2007
> after all...?

By all means, yes.

I do not think we particularly wanted to use 8859-1, but nothing
in Documentation/ tells the asciidoc toolchain that the document
should come out in UTF-8 either.
