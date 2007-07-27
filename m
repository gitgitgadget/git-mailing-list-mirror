From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui wording suggestions
Date: Thu, 26 Jul 2007 22:09:37 -0700
Message-ID: <7vvec64elq.fsf@assigned-by-dhcp.cox.net>
References: <20070726111902.xqkxcdlsbo8w4c8k@webmail.tu-harburg.de>
	<20070727044009.GF20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:09:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEI5A-0005AJ-DB
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbXG0FJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbXG0FJj
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:09:39 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:38954 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbXG0FJj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 01:09:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727050939.WEWO1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Jul 2007 01:09:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UV9d1X00M1kojtg0000000; Fri, 27 Jul 2007 01:09:38 -0400
In-Reply-To: <20070727044009.GF20052@spearce.org> (Shawn O. Pearce's message
	of "Fri, 27 Jul 2007 00:40:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53887>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Christian Stimming <stimming@tuhh.de> wrote:
>> Unifiy wording to say "to stage" instead of "to add" always.
> ...
>> With this patch I'd propose to talk every only about "stage" instead  
>> of "add". IMHO that's just the logical conclusion of the above wording  
>> decision. What do you think?
>
> Yes, I agree.  This is a necessary change, the current wording is
> very confusing.

Looking at the expressions used in the application from the
point of view of translating the words to (or expressing the
concept in) another language helps finding more appropriate
wording even in the original language.

"Add" is a simple and nice word, but it is too broad, so "to
stage" is an improvement.  The translated message for "to stage"
for Japanese we will probably end up choosing would translate
back to English as "Schedule for commit".
