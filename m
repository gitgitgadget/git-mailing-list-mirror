From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added example hook script to save/restore permissions/ownership.
Date: Fri, 14 Sep 2007 11:24:07 -0700
Message-ID: <7vy7f99kc8.fsf@gitster.siamese.dyndns.org>
References: <11895299441298-git-send-email-jjengla@sandia.gov>
	<118952994432-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Josh England" <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 20:36:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWFpu-0004ZJ-7N
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 20:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbXINSYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 14:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbXINSYK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 14:24:10 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48784 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbXINSYI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 14:24:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070914182408.LPXB6851.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 14 Sep 2007 14:24:08 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id oJQ71X00N1gtr5g0000000; Fri, 14 Sep 2007 14:24:07 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58173>

Does nobody find these two patches useful?

I do not feel strong need myself to have them but on the other
hand I do not see anything wrong with them, so I am inclined to
apply it to 'master' soon, unless somebody objects.
