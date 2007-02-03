From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] builtin-branch: be prepared for ref-logging
Date: Sat, 03 Feb 2007 12:54:05 -0800
Message-ID: <7v64aj3qtu.fsf@assigned-by-dhcp.cox.net>
References: <11705213662728-git-send-email-tutufan@gmail.com>
	<11705277471962-git-send-email-hjemli@gmail.com>
	<7vr6t73tsi.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580702031238i612acda0p26aba8e3df747b1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 21:54:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDRtk-0003n8-BC
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 21:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXBCUyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 15:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbXBCUyJ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 15:54:09 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:48070 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751632AbXBCUyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 15:54:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203205407.WLAB1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 15:54:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K8u51W00m1kojtg0000000; Sat, 03 Feb 2007 15:54:06 -0500
In-Reply-To: <8c5c35580702031238i612acda0p26aba8e3df747b1a@mail.gmail.com>
	(Lars Hjemli's message of "Sat, 3 Feb 2007 21:38:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38600>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 2/3/07, Junio C Hamano <junkio@cox.net> wrote:
>> Funny thing is that I thought I fixed this already
>
> Infact, you did:
>
>  http://article.gmane.org/gmane.comp.version-control.git/37197
>
> Don't know what happend to this one...

Thanks, and I do think that patch is better ;-).
