From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Fix misspellings
Date: Fri, 22 Jun 2012 12:37:22 -0700
Message-ID: <7vehp7p28d.fsf@alter.siamese.dyndns.org>
References: <1340389329-18325-1-git-send-email-muhtasib@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leila Muhtasib <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 21:37:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si9fg-00089U-Fq
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 21:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762636Ab2FVThZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 15:37:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762600Ab2FVThY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 15:37:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF8C6FA6;
	Fri, 22 Jun 2012 15:37:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ey24D9qlETZssvx/2Fj0Hb8Se4k=; b=QV30qR
	ut4EV/ZKvA8EGQF61QUoPXsMo8uYqWLVt60ef6pAo90EUokfmmI3NIUtTtT4e7lu
	/B7UTDPjLh4xirGZFNcWg8aAZSL6pNigSJLUZQtkbhJoEst3JxJoXL8DwUV0mJLp
	U3AbDGJLY4As9xr6JzoG4HGAUxhs9crvCeGs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cBH4fYXy922J55/MFzCy1JUdYfZqACQa
	cWlrEzqlo4yBE0nZCNe3Mecx5h23O83x4ZlbawbGo2dRrkuBq+G49yd/G9db91zj
	BAIQtHlqLnTIe736t9p8T4OTmoSh2BpffPGJPOqqoy/DwOI+eGuv0H2aB5Iq13F6
	eUgbd0R5QNI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DD26FA5;
	Fri, 22 Jun 2012 15:37:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFC966FA4; Fri, 22 Jun 2012
 15:37:23 -0400 (EDT)
In-Reply-To: <1340389329-18325-1-git-send-email-muhtasib@gmail.com> (Leila
 Muhtasib's message of "Fri, 22 Jun 2012 14:22:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0BAC1F0-BCA1-11E1-8813-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200461>

Thanks; "git grep overriden" finds a few more hits in t/, which we
may also want to fix.
