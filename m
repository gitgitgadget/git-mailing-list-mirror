From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Doc: Improve shallow depth wording
Date: Tue, 18 Sep 2012 13:36:25 -0700
Message-ID: <7vmx0nkr06.fsf@alter.siamese.dyndns.org>
References: <1347793083-4136-4-git-send-email-philipoakley@iee.org>
 <7vlig9w6a7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:36:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE4X8-0001II-24
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 22:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab2IRUg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 16:36:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148Ab2IRUg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 16:36:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C1718CB3;
	Tue, 18 Sep 2012 16:36:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OtUN7AhCHlZYMIWPtDavckLjWBk=; b=BWa/oE
	srfBvZpZvJMQWGw4V5YMUyS5MhkrFwYjIlQpGxac1WHWDW1BB/3LPIriuXaH5e/G
	/53vd/xkq1HY+eN4QHm+tsa+7xjdTKzb1oCoEG1KZac7PxX+ipwuGq5F5xxUzTCx
	Lul+ASYzWtXqpkNfghYtmtZQoIbfI3GjxOjHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eMwbkN/GZgntGgaTUBRIYZA3GnRGg05G
	/XfbK3/NcNVkifQllQA/AoDF1JeGChFuPcfkwBbbki8Wff1VzYUo5QzLtcUFiGoz
	lA/FqjQtvRp5VASCcLv8LEmWbo8S1RoRgbZ11+hnL54kCyJzUhIfqCuaZPtoXt1x
	86hLJZkY8Zk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48E348CB2;
	Tue, 18 Sep 2012 16:36:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA5BF8CB1; Tue, 18 Sep 2012
 16:36:26 -0400 (EDT)
In-Reply-To: <7vlig9w6a7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 16 Sep 2012 22:46:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84D1ED24-01D0-11E2-9CC4-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205869>

Junio C Hamano <gitster@pobox.com> writes:

> Philip Oakley <philipoakley@iee.org> writes:
>
>> Avoid confusion in compound sentence about the start of the commit set
>> and the depth measure. Use two sentences.
>
> Dropping the first ',' after "positive depth" does not seem to make
> it any easier to read (I personally think it makes it a lot harder
> to read).  Splitting the tail-end of the sentence into a separate
> sentence does make it easier to read, though.

Will add ',' locally and queue; no need to resend.

Thanks.
