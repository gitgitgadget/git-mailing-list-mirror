From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 20:06:13 -0700
Message-ID: <7vps2fc196.fsf@assigned-by-dhcp.cox.net>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	<fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	<a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, git@vger.kernel.org
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 05:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDtgB-0003Ro-33
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 05:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbXGZDGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 23:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756354AbXGZDGQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 23:06:16 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38950 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbXGZDGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 23:06:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726030615.YQKN1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Jul 2007 23:06:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U36D1X00a1kojtg0000000; Wed, 25 Jul 2007 23:06:14 -0400
In-Reply-To: <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
	(Dmitry Kakurin's message of "Wed, 25 Jul 2007 19:26:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53750>

"Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:

> On 7/25/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> What features is mingw port missing?
> Well, 'git commit' from a regular cmd prompt does not work.
> IMHO, That's a pretty serious omission  :-).

I was under the impression that is only because you do not have
MSYS installed.  Doesn't Windows people have automated way to
pull and install other packages on the dependency?
