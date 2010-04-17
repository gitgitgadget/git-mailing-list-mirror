From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-instaweb: pass through invoking user's path to
 gitweb CGI scripts
Date: Sat, 17 Apr 2010 10:32:47 -0700
Message-ID: <7vd3xy2dds.fsf@alter.siamese.dyndns.org>
References: <59ee8c7a3052ed747b5dbaa0a1d0e51aded9c413.1271337968.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 19:33:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3BtB-00075Z-RE
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 19:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790Ab0DQRc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 13:32:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab0DQRc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 13:32:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B2BAB416;
	Sat, 17 Apr 2010 13:32:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PJoXbwtcPGSDiZ/Yj3fLHyqpcQM=; b=ofsUSx
	K1SUWTB3kFDazFvGKy5oGx8iqmeSoJ9mpDzgxSLOhTG4iumEYQL85wfwwn3BvSq9
	5QJlXRvnZDciXjbaDwDe1i+bNfF2xlHh8+T7xLhDZbMfKqRVkLWcTIppMALqrrX/
	SI5YZG3qXcWda70SKCtJwwtOSou+nzBEItaiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZsUghySiB/axJ3tdDmU8Z+gM7i61acZa
	mfKDu+0bEfAjk+sLGkHOi5tFiiNJaD8gei/Kb2waMtb9X0mfz/7mLa15lVLyz9F4
	/VJeK6PAy4nUlpvEjD3xOdkQaWx8qBzZGVOKpTz42F+K0uCtVN0cBKAihoNRw7qW
	0NsN9p01qI4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9EA6AB412;
	Sat, 17 Apr 2010 13:32:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB7E0AB40E; Sat, 17 Apr
 2010 13:32:49 -0400 (EDT)
In-Reply-To: <59ee8c7a3052ed747b5dbaa0a1d0e51aded9c413.1271337968.git.chris@arachsys.com>
 (Chris Webb's message of "Thu\, 15 Apr 2010 14\:29\:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41835582-4A47-11DF-8CC3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145162>

Thanks, both.  Will queue.
