From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Mon, 03 Jun 2013 08:28:29 -0700
Message-ID: <7vwqqbjjs2.fsf@alter.siamese.dyndns.org>
References: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
	<CALWbr2z7zY6sm_6OTiZhgpjU4i3WwHdbc75V6-0O_0JVMx+svA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 17:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjWgX-0002BZ-1M
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 17:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758157Ab3FCP2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 11:28:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032Ab3FCP2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 11:28:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A575F24E6D;
	Mon,  3 Jun 2013 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=m5eDpt
	t4AAyYCPPoM9/r7I9OLFkEFy0el05pA6VSnUvBgP5CX2/RlwnG2MIyfXg6n0V5t/
	P2d+MgXv41Ad3LXiZ/IdoM8945HGfCVkrC+qqPSGEnJ/F/an0BtUBclTrE69V4HH
	WvKclAIwOjWSgJuyJvoNjllrfEr4sCZbkyMvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rBuklq875dWH0tZ8LKyFpy8wsZ/vgMjo
	ri5dzA4yRmJZBxAa091APJboM6khwcIHJUcw1OAZbhj7SxGlGkA5IBHFQR321VTh
	o6UX3hHi3F10qKLYwBe5VEzDNMq63tTC5KBeGJXhSFkxq/OL2CYiutcf0x/jB72J
	wUFpcc0ZE+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9010A24E6C;
	Mon,  3 Jun 2013 15:28:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D48924E69;
	Mon,  3 Jun 2013 15:28:30 +0000 (UTC)
In-Reply-To: <CALWbr2z7zY6sm_6OTiZhgpjU4i3WwHdbc75V6-0O_0JVMx+svA@mail.gmail.com>
	(Antoine Pelisse's message of "Mon, 3 Jun 2013 13:23:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F0467E2-CC62-11E2-8179-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226220>

Thanks.
