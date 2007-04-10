From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 12:32:38 -0700
Message-ID: <7v6484vxd5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
	<81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
	<Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
	<81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com>
	<Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 05:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbM55-0001H6-By
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 21:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbXDJTck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 15:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbXDJTck
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 15:32:40 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45717 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbXDJTcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 15:32:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410193238.JGMK1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 15:32:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lXYe1W00N1kojtg0000000; Tue, 10 Apr 2007 15:32:38 -0400
In-Reply-To: <Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 10 Apr 2007 09:07:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44173>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 10 Apr 2007, Alex Riesen wrote:
>> 
>> It is already "merged somewhere": as soon as the patches left landed
>> on vger, it is not possible to loose (and even destroy) them.
>> The feature is just too much sought after.
>
> Well, unless it hits something like Junios 'pu' (or 'next') branch, or 
> somebody (like you?) ends up maintaining a repo with this, it's just 
> unnecessarily hard to have lots of people working together on it..

Well, I was planning to apply this directly on 'master' after
giving them another pass.
