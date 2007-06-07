From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation typo.
Date: Wed, 06 Jun 2007 19:09:03 -0700
Message-ID: <7vzm3csegw.fsf@assigned-by-dhcp.cox.net>
References: <11810823561507-git-send-email-madcoder@debian.org>
	<7v4plkzsuj.fsf@assigned-by-dhcp.cox.net>
	<20070606221806.GA23830@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 04:09:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw7Qy-0008DA-UT
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 04:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935438AbXFGCJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 22:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935451AbXFGCJF
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 22:09:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49191 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935438AbXFGCJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 22:09:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607020905.SBPU7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 22:09:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8S931X0171kojtg0000000; Wed, 06 Jun 2007 22:09:04 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49340>

Pierre Habouzit <madcoder@debian.org> writes:

>> Unfortunately our documentation pages were written with AsciiDoc
>> 7, and are not AsciiDoc 8 compatible.
>> 
>> With -aasciidoc7compatible, AsciiDoc 8 is _supposed_ to behave
>> compatibly, but in reality it does not format our documentation
>> correctly.  It certainly is possible that AsciiDoc 7 "happens to
>> work" with our documentation pages, and maybe the way we abuse
>> mark-ups can be argued the bug in _our_ documentation, but
>> nobody on our end worked on finding a satisfactory solution to
>> make our documentation format correctly with _both_ versions of
>> AsciiDoc yet.
>>  ...
>
>   Okay, I see, sorry for the noise then.

Well, it was NOT a noise.  Making the docs usable with both 7
and 8 is a task waiting for a volunteer ;-).
