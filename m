From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Mon, 05 May 2014 13:23:17 +0200
Message-ID: <87zjiwsc4a.fsf@fencepost.gnu.org>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org>
	<m2mwexke34.fsf@linux-m68k.org> <5366A09E.6030802@kdbg.org>
	<87ppjt6xjv.fsf@igel.home> <87lhugu7iw.fsf@fencepost.gnu.org>
	<87vbtk60lh.fsf@igel.home> <87d2fstuzw.fsf@fencepost.gnu.org>
	<87r4485vve.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:55:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhyK-0005Yp-4B
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393AbaEELXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 07:23:20 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:59252 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbaEELXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 07:23:20 -0400
Received: from localhost ([127.0.0.1]:58292 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WhGzN-0004w5-JS; Mon, 05 May 2014 07:23:17 -0400
Received: by lola (Postfix, from userid 1000)
	id 3D857E048F; Mon,  5 May 2014 13:23:17 +0200 (CEST)
In-Reply-To: <87r4485vve.fsf@igel.home> (Andreas Schwab's message of "Mon, 05
	May 2014 13:05:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248160>

Andreas Schwab <schwab@linux-m68k.org> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Your premise is _not_ assumed in my statement.  My premise was "a
>> pointer to something of the same type of [the struct's] first member".
>> That does quite explicitly _not_ state that an object of struct type is
>> in existence.
>
> So you are not taking about struct object_id, and it's irrelevant to
> this thread.
>
> This thread is about objects of type struct object_id, and their address
> is always the same as the address of its first member.  Nothing else is
> relevant.

Have it your way.  I am too old for selective quotation games.

-- 
David Kastrup
