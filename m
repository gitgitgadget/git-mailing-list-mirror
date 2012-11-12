From: Junio C Hamano <gitster@pobox.com>
Subject: Thanking the interim maintainer
Date: Sun, 11 Nov 2012 19:12:26 -0800
Message-ID: <7vlie7ldk5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Mon Nov 12 04:12:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXkS4-0002Zm-4x
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 04:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab2KLDMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 22:12:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262Ab2KLDM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 22:12:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD7F7984A;
	Sun, 11 Nov 2012 22:12:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	aLgGhq7iKXjSfdZDSZ8djLJoYI=; b=DuXGR07itVY7Uo5AdoEJt5C8g5v03qOxp
	jjuVfX2WJbZWi4kdYpOsD2vhULzyhXP+bky/Swk8qXdl9hKUUrnfLEjWCTmupbLZ
	5LvrubPtIQQke3KZ+bjxSe48TAPQSDA+gp1oOOYlSUO0ZPe8DYhpiDYuBbANMJOB
	o0HtF/LHfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=NR4GG+T/JViKie4U3WloTwjeYkeTwDZGhYkYEo6OTD0W+YrjwcZSICqH
	i91AL0CqAfcy96h3iEvyLE9A2Q5Gf2CoEp7d2e3AC8APa1lhMERgUD6+HrUBbHhv
	DS6asQFGCkD4jj/mnrVEaWyomyGGnE66MwqiRpZlfey6+oVx9Cg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 991D29849;
	Sun, 11 Nov 2012 22:12:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E85249848; Sun, 11 Nov 2012
 22:12:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9E5F326-2C76-11E2-9D6E-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209461>

I am physically back but still am far from catching up with the list
traffic (yet).  After skimming my inbox, it appears that you have
done a magnificent job keeping track of topics in flight and merging
low-risk fixes early to the 'master' branch.

I am hoping that I can ask you to do another issue of "What's
cooking" (or two) while I catch up with the traffic, to collect all
worthy patches that are already published on the list ;-).  After
that, let us arrange for me to pick up the tips of topic branches
you have and take it over (just telling me to run "log --oneline
master..pu" might be sufficient if there is no "tentatively ejected"
topic).

Thanks.
