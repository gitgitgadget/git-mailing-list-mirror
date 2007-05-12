From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Document patch syntax.
Date: Sat, 12 May 2007 12:02:24 -0700
Message-ID: <7vodkpzwzj.fsf@assigned-by-dhcp.cox.net>
References: <20070512120704.22970.45140.stgit@gandelf.nowhere.earth>
	<20070512135644.GA28039@diana.vm.bytemark.co.uk>
	<20070512143827.GE16903@nan92-1-81-57-214-146.fbx.proxad.net>
	<20070512183255.GD28039@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat May 12 21:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmwrY-00012p-3p
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912AbXELTCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 15:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756756AbXELTCg
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:02:36 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50644 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757000AbXELTCf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2007 15:02:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512190235.VYJX22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 15:02:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yK2S1W00C1kojtg0000000; Sat, 12 May 2007 15:02:32 -0400
In-Reply-To: <20070512183255.GD28039@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Sat, 12 May 2007 20:32:55
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47073>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-05-12 16:38:27 +0200, Yann Dirson wrote:
>
>> However, that makes me think we should probably use guideline for
>> the docs - here comes the question of which convention to use when
>> refering to the user. Do we address her directly ("you"), indirectly
>> ("the user", "her" - don't remember where the "female user" use
>> comes from, but we could maybe follow this), even more indirectly
>> ("one"), or any other way ?
>
> I'd go with "you", or possibly "one" (but I strongly prefer "you").
> Talking about the user in the third person ("the user", "her", etc.)
> seems actively wrong when we are instructing the user on how to do
> things.

With the context in question, I find 'the user' is the most
natural and neutral.

I think the "female user" use is not so widely accepted.  I
always found it to be a sign that the author, a lonely male nerd
developer, is wishing to live in a dream world where he becomes
a hero by helping an attractive female user that he would never
have chance to interact with otherwise in his real life ;-).

=46or tutorial/walkthru type of documentation, my usual preference
is "we", not "you".  "Now our little repository should be in
this shape."  "Let's change our Makefile to do a bit more."
That sets the tone that a slightly more knowledgeable friend is
helping the user by working together with him, instead of an
expert talking to a stupid user from a high place, but that is a
bit offtopic.
