From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Thu, 12 Apr 2007 23:35:22 -0700
Message-ID: <7v3b34hjdh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
	<17951.6252.457936.428919@cargo.ozlabs.ibm.com>
	<46a038f90704122307i76f96029n75425410bc40ad82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 08:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcFNo-0005wz-3F
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 08:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbXDMGfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 02:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbXDMGfc
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 02:35:32 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58051 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbXDMGfX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 02:35:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413063523.TIWI1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Apr 2007 02:35:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mWbN1W00D1kojtg0000000; Fri, 13 Apr 2007 02:35:23 -0400
In-Reply-To: <46a038f90704122307i76f96029n75425410bc40ad82@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 13 Apr 2007 18:07:15 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44390>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 4/13/07, Paul Mackerras <paulus@samba.org> wrote:
>> Side-by-side would be more challenging.
>
> <wish>If someone gets started on side-by-side, I'd love to have
> char-level diff colouring,...
> icecream too.</wish>

Is it different from the --color-words (whose implementation I
happen to hate)?
