From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2009, #01; Fri, 12)
Date: Fri, 12 Jun 2009 12:40:37 -0700
Message-ID: <7vhbyl6y16.fsf@alter.siamese.dyndns.org>
References: <7v1vppbyud.fsf@alter.siamese.dyndns.org>
	<rSzubjF8CnevXkwWDxaenB5zuhD67OB8uzhVcZ-gVR8YYXa1S1h2tg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 12 21:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFCcH-0005a9-Mx
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 21:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbZFLTkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 15:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754200AbZFLTkf
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 15:40:35 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49531 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbZFLTkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 15:40:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090612194036.QQBG18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 12 Jun 2009 15:40:36 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 37gd1c0074aMwMQ047gdW9; Fri, 12 Jun 2009 15:40:37 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=NAODWrZ5NzMA:10 a=yeNtOkGfiRIA:10
 a=eVJgW3NqyQU6tPYO5wQA:9 a=epDIXUhGAr2lKtOlPO-gnKyO70EA:4
X-CM-Score: 0.00
In-Reply-To: <rSzubjF8CnevXkwWDxaenB5zuhD67OB8uzhVcZ-gVR8YYXa1S1h2tg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 12 Jun 2009 13\:38\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121444>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:
>
>> [Will merge to "master" soon]
>> 
>> * bc/solaris (Sun Jun 7 07:40:29 2009 +0200) 10 commits
>
> ...  So I think all of that is ready to
> go.

Thanks.

>> I lost
>> track of the status of the tip patch for autoconf.  Is it ready to go?
>> Comments from Solaris folks are appreciated.
>
> I can't test it.  No autotools on these machines.
>
> Ralf said it was all pretty mechanical and with what little autoconf
> experience I have, his patch looks like it would do the trick, even
> if it would add -lresolv unnecessarily sometimes (i.e. for any Solaris
> not requiring NO_IPV6).

Thanks again.  My reading of that patch agrees with yours.
