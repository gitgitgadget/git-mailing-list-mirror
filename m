From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of contrib/stg-sink.
Date: Tue, 17 Apr 2007 17:10:04 -0700
Message-ID: <7vlkgqlezn.fsf@assigned-by-dhcp.cox.net>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth>
	<4625314E.2050103@vilain.net>
	<b0943d9e0704171702j1bced65cja7a1f2e55a5b96d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Sam Vilain" <sam@vilain.net>, "Yann Dirson" <ydirson@altern.org>,
	git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 02:10:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdxkS-0003fg-Os
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 02:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030949AbXDRAKI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 20:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030960AbXDRAKH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 20:10:07 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35906 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030949AbXDRAKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 20:10:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418001005.LLHD1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Apr 2007 20:10:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oQA41W00P1kojtg0000000; Tue, 17 Apr 2007 20:10:05 -0400
In-Reply-To: <b0943d9e0704171702j1bced65cja7a1f2e55a5b96d9@mail.gmail.com>
	(Catalin Marinas's message of "Wed, 18 Apr 2007 01:02:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44845>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 17/04/07, Sam Vilain <sam@vilain.net> wrote:
>> Yann Dirson wrote:
>> > This is the rewrite in python of by stg-sink written in perl.
>> >
>> > I changed the name to "bury" since it seems more descriptive of what
>> > it does, despite being less of an opposite to "float" than "sink" was.
>>
>> But 'bury' means to hide or even kill.
>>
>> How about "raise" and "lower" ?
>
> Or "immerse" ("immerge"?) as another opposite of "float" :-)
>
> I don't have any opinion on this, it's up to Yann to argue.

As a user, to me, 'bury' feels perfect and I am not annoyed by
the connotation, perhaps maybe I am used to 'bury-buffer' in
Emacs.
