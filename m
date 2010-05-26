From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test get_git_work_tree() return value for NULL
Date: Tue, 25 May 2010 22:07:18 -0700
Message-ID: <7vocg3qmih.fsf@alter.siamese.dyndns.org>
References: <20100522122127.GA13372@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed May 26 07:07:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8q4-0005MW-Lk
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab0EZFH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:07:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab0EZFHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:07:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA0D1B67B3;
	Wed, 26 May 2010 01:07:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=egzts7h10eiAVvpvU9g54eU
	0E9ih0tehUhAHMI1PYDqvezigR/2FVyTJI2s4fJMkWbLlb+cDSUig26dmez/fFIX
	LDQfRA0h4o+xc4xw9uw4BiEZ2HoGtFC/BetJ3R74J2c93CKnZ57Dfnr7M4t4mt5A
	S+iMwUglyQahUW1DKDGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=rCp0x5sfgsobfl1d/e2t66gISpYWyIJc4Bl2aVa/9y27ESV1J
	+HaGaFEfWv2UF3fA+JMq0IBhTi2KiRgG9JD1rr63/foFPIMEz7qi2zTx+WULczhh
	aUtDeAjwF7aXA3jJ9uylrH7een/7NYwr5OyLefI39Z/eUYHOiknLUoN6es=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86C10B67B1;
	Wed, 26 May 2010 01:07:22 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D64ABB67A7; Wed, 26 May
 2010 01:07:19 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 91300DC2-6884-11DF-99ED-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147737>

Thanks.
