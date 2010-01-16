From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH 2/3] difftool: Add '-x' and as an alias for '--extcmd'
Date: Sat, 16 Jan 2010 07:44:18 -0600
Message-ID: <19281.49842.4522.770104@blake.zopyra.com>
References: <1263539762-8269-1-git-send-email-davvid@gmail.com>
	<1263539762-8269-2-git-send-email-davvid@gmail.com>
	<7vvdf3xiav.fsf@alter.siamese.dyndns.org>
	<19280.51182.981853.561841@blake.zopyra.com>
	<7vbpguoo4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 14:44:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW8xL-0002pj-FV
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 14:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab0APNoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 08:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006Ab0APNon
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 08:44:43 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:57823
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752146Ab0APNom (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 08:44:42 -0500
Received: (qmail 23631 invoked by uid 500); 16 Jan 2010 13:44:21 -0000
In-Reply-To: <7vbpguoo4y.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137229>

On Friday, January 15, 2010 at 17:05:17 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> On Friday, January 15, 2010 at 11:46:32 (-0800) Junio C Hamano writes:
>>>David Aguilar <davvid@gmail.com> writes:
>>>
>>>> -# Copyright (c) 2009 David Aguilar
>>>> +# Copyright (c) 2009-2010 David Aguilar
>>>
>>>Just a very minor issue.  I'd prefer to see:
>>>
>>>	Copyright (c) 2008, 2009, 2010
>>>
>>>over
>>>
>>>	Copyright (c) 2008-2010
>>
>> Why?
>
>I learned this from <http://www.gnu.org/licenses/gpl-howto.html>.  The
>advice doesn't say _why_, but my understanding of the rationale behind it
>is that the international convention that governs this copyright
>notice specifically mentions "the year of publication", not "range of
>years" (UCC Geneva text, Sept. 06, 1952, Article III 1.).
>
>Berne convention does not require such a copyright notice, and many
>countries are signatories of both treaties, so the whole copyright notice
>may be a moot point in many countries, but it matters in some.  As long as
>the file (and the GNU advice cited above) is being cautious by having the
>notice, it would be better to be equally cautious and spell the years of
>publication out.
>
>But I am not a lawyer.

Hmm, interesting.  My wife is a lawyer, maybe I'll sic her on this.
My guess is that if this came to court, a judge would laugh at anyone
who tried to assert a meaningful difference.

Good to know though, thank you for taking the time to explain this.


Bill
