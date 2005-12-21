From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.0.0b quickfix
Date: Wed, 21 Dec 2005 15:32:49 -0800
Message-ID: <7vpsnqyqji.fsf@assigned-by-dhcp.cox.net>
References: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net>
	<43A9E15F.1060808@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 00:32:56 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpDS2-0005jV-Is
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 00:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVLUXcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 18:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVLUXcw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 18:32:52 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:24284 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964990AbVLUXcv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 18:32:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221233101.NKPJ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 18:31:01 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43A9E15F.1060808@zytor.com> (H. Peter Anvin's message of "Wed,
	21 Dec 2005 15:12:31 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13916>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>> I've pushed out a v1.0.0b maint release to fix a bug in HTTP
>> fetch that was discovered today X-<.
>>
>
> Wouldn't it make more sense for the maintenance release to be 1.0.1?

Maybe.  Nobody mentioned this about 0.99.9a, 0.99.9b... though.

The series 1.0.0[a-z] is meant to parallel 2.6.14.[123...]
"fixes only"; OTOH I'd like to allow 1.0.[123...] to contain
enhancements.
