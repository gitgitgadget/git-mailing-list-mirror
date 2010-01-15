From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add push --set-upstream
Date: Fri, 15 Jan 2010 10:19:58 -0800
Message-ID: <7vhbqnz0vl.fsf@alter.siamese.dyndns.org>
References: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:20:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqmL-0005yR-6R
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 19:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757909Ab0AOSUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 13:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757903Ab0AOSUG
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 13:20:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757834Ab0AOSUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 13:20:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C8AD91A1B;
	Fri, 15 Jan 2010 13:20:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z7iuGvCl8kG8+KhSLC7asZ3xzpU=; b=OJBS0L
	LQsYEbYz1WHxncYPO6docxgVzbei9dSu+fb/XIryjWXC7IAjDyuA2aQF4FaAhu7J
	Fo9Ep4BoGt7HKfqaYo1cXYfKQeUpzY4LBwrnxtorwJiYaoTZboQfNT2DHK7nhdIN
	yHvF2rO3OUKFx8M+jSn77LPz2zIvr6iFbibos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WdSA+VqjhLkWLWcqZBVxBohLxjEN6xf4
	zY783Ytr2zmMi2Dh8OdUvq7qC3p18Y+NYj4fgv+GQ8AnrF9dXRzpCyuNxrMICjNI
	SLR5ZTt6Ec46z5PShFciQwAPhyNz3lx8cZ1HXUGvq5QYsXu7ZP84FoAuP1McS7/u
	LaA01XKoXXE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DBF8E91A16;
	Fri, 15 Jan 2010 13:20:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4366B91A11; Fri, 15 Jan
 2010 13:20:00 -0500 (EST)
In-Reply-To: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Fri\, 15 Jan 2010 18\:36\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 993F637A-0202-11DF-9691-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137096>

Very competently done.  Will look forward to see the conclusion of the
follow-up discussions I haven't read but see in my mailreader.

Thanks.
