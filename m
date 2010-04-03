From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: update defaults for modern Cygwin
Date: Sat, 03 Apr 2010 11:28:49 -0700
Message-ID: <7vr5mw8k66.fsf@alter.siamese.dyndns.org>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com>
 <7vaatmmju9.fsf@alter.siamese.dyndns.org> <4BB5F94F.3090403@redhat.com>
 <20100403074700.GA24176@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>, git@vger.kernel.org,
	jon.seymour@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 20:29:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny85m-0006BX-2a
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 20:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab0DCS3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 14:29:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab0DCS3E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 14:29:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58B3BA69EE;
	Sat,  3 Apr 2010 14:29:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=sOqJ2UBtSnbadYTqlgupqV1JZQs=; b=vbUu5H
	x1zvJwlrOya/0ebpN7KkGdeTmzfVSnaUIn5p2c+J8j1R0o/sGUPqj/qoyxUah2Z2
	xNi6QcO5zRfqY12q5VqODUSAc34ATBmPdw3ZUAR1H+aee7tmKE0U3Ar8kb46u4mf
	y36FaI+ALVNINnpTsiQ3UaUF4QC5OPvQd08F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C4JFOm5ZakBYw/pFhr9ZuyCUzKUQN/au
	MrWnyrsevllAi+S0S3cIIAKdg3luotVhrlG/AAZhRcVIvvFU6i1lGZ8Q2OMU3EVq
	gc+DT9gih7310vUWGQNQ/5bj7EbHioXp1ZT5A44SxFIYgdzJ3IZOTuSk/wMCMGR7
	raHCPf6g6yI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07B04A69ED;
	Sat,  3 Apr 2010 14:28:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48855A69E9; Sat,  3 Apr
 2010 14:28:50 -0400 (EDT)
In-Reply-To: <20100403074700.GA24176@progeny.tock> (Jonathan Nieder's message
 of "Sat\, 3 Apr 2010 02\:47\:00 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3C0C196-3F4E-11DF-8380-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143895>

Thanks, will queue.  By the way, please spell scissors as 8< or >8 not
with a per-cent at least for now.
