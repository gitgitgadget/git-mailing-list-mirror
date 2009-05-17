From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Sun, 17 May 2009 10:58:23 -0700
Message-ID: <7v1vqnipc0.fsf@alter.siamese.dyndns.org>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
	<m3zldcjc76.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 19:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5kd5-0002z2-LB
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 19:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbZEQR6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 13:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbZEQR6X
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 13:58:23 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50671 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbZEQR6W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 13:58:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090517175823.SHKX20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 17 May 2009 13:58:23 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id shyP1b0074aMwMQ04hyPy4; Sun, 17 May 2009 13:58:23 -0400
X-Authority-Analysis: v=1.0 c=1 a=jpUCGHAuqP8A:10 a=AqR8L7kc4dQA:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=j90HMuO1YEFE4PTEUsUA:9
 a=7mlBsnflLGCZ0iM-8YKVLMKLitcA:4 a=MSl-tDqOz04A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <m3zldcjc76.fsf@localhost.localdomain> (Jakub Narebski's message of "Sun\, 17 May 2009 02\:45\:24 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119404>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * jn/gitweb-cleanup (Mon May 11 19:45:11 2009 +0200) 8 commits
>>  + gitweb: Remove unused $hash_base parameter from
>>    normalize_link_target
>>  + gitweb: Simplify snapshot format detection logic in
>>    evaluate_path_info
>>  + gitweb: Use capturing parentheses only when you intend to capture
>>  + gitweb: Replace wrongly added tabs with spaces
>>  + gitweb: Use block form of map/grep in a few cases more
>>  + gitweb: Always use three argument form of open
>>  + gitweb: Always use three argument form of open
>>  + gitweb: Do not use bareword filehandles
>
> Why "gitweb: Always use three argument form of open" is twice here?

Perhaps you sent in a malformed message and I did not notice nor hand
munge it?  Let's see...

      Message-ID: <200905110329.40666.jnareb@gmail.com>

Yeah, that's it.
