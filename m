From: Junio C Hamano <gitster@pobox.com>
Subject: Re: plain text only policy prohibits the use of android based mobile
 devices
Date: Wed, 18 May 2011 16:31:14 -0700
Message-ID: <7v39kbbn7h.fsf@alter.siamese.dyndns.org>
References: <BANLkTik5g+oahTuTZ5BSOunQMfzGNRZ-7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 01:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMqDA-0004Ei-SG
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 01:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090Ab1ERXbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 19:31:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933Ab1ERXbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 19:31:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2762D5B39;
	Wed, 18 May 2011 19:33:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aVx7N9YwNjLxaXXuYX1a6i9cdS4=; b=PMvVZu
	3IYcTY0akdgtiMYk70ev6dgOadpYzn98qi5R5VHQCF8DoxsJRP0QmZaG9z559FHw
	r9biIJFFuPkhlT2c3xzIL6lgWPjGsbCHQhmYp9uhr8ODBwsKs01g+Wmz+i6bBnal
	5OUaJ33YUl98yGqOC5fMY6ibtwBf3RnypP0SU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GRuVjXAHABxYD6mrADZevJlHrYTQLOo+
	9nbSCRs27rqSLTFGORjUA99SHA6erQCH+5/u5lbFeuKzIXrkMQMcI1EFqF/clPB/
	054TM2qPgOJI0YRZa227GZZ30sg6d/2PqDw401IOjJp4WhV+99Dl7IV81RHBfEpJ
	uOrkm7ujIe4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05B0A5B35;
	Wed, 18 May 2011 19:33:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2FA225B34; Wed, 18 May 2011
 19:33:23 -0400 (EDT)
In-Reply-To: <BANLkTik5g+oahTuTZ5BSOunQMfzGNRZ-7Q@mail.gmail.com> (Eugene
 Sajine's message of "Wed, 18 May 2011 18:03:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AEF2FF0-81A7-11E0-BC97-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173917>

Please send such requests to the list admins at vger.kernel.org directly.
I do not think people that are active on this list do not have much
influence on the filtering policy, and also I suspect not many list admins
read this list to trawl for request like this.

Having said that, I personally would not want to see non-text messages
myself, even though I often find myself not having any access to the list
but via gmail and I find it quite limiting. But I tend to consider that
not allowing pure text messages is a gmail bug/misfeature and needs to be
fixed not by allowing html cruft on the list, but by enabling poor gmail
users to send pure text when they want to.

Yes, I sit in Mountain View, but I suspect that pure text messages are not
anywhere near the top of the task list of the people who run gmail, and I
know I do not have much influence on that matter, either.
