From: dleong <dleong@celsinc.com>
Subject: Re: How to move users from SEU (AS400) to Git?
Date: Wed, 2 Dec 2015 11:09:57 -0700 (MST)
Message-ID: <1449079797917-7643587.post@n2.nabble.com>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com> <efe2b6d70905121431p79c05addh1cd5759221ae911c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 19:10:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Bqu-0007VA-NR
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 19:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbbLBSJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 13:09:59 -0500
Received: from mwork.nabble.com ([162.253.133.43]:61171 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921AbbLBSJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 13:09:58 -0500
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id A2BBF2F05CB9
	for <git@vger.kernel.org>; Wed,  2 Dec 2015 10:11:08 -0800 (PST)
In-Reply-To: <efe2b6d70905121431p79c05addh1cd5759221ae911c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281897>

I stumbled on this topic while doing a research on how to move RPG source
control to adopt using Git. I wonder if the original question was answered.
My company would love to have a more central system to maintain both RPG
codes and javascript codes. We use Rational Developer exclusively (no more
SEU) for our developers and we do not have budget to use Team Concert from
IBM. So Git seems like a good solution.

Finally. There are still a lot of RPG programmers out there. If you have not
checked lately, RPG is no longer a language with fix format column
structure: 
http://www.ibm.com/developerworks/ibmi/library/i-ibmi-rpg-support/
<http://www.ibm.com/developerworks/ibmi/library/i-ibmi-rpg-support/>  




--
View this message in context: http://git.661346.n2.nabble.com/How-to-move-users-from-SEU-AS400-to-Git-tp2870074p7643587.html
Sent from the git mailing list archive at Nabble.com.
