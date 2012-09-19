From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 7/8] Doc clean: add See Also link
Date: Tue, 18 Sep 2012 20:58:07 -0700
Message-ID: <7vehlyirzk.fsf@alter.siamese.dyndns.org>
References: <1348010734-664-8-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 05:58:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEBQe-0005yE-7X
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 05:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab2ISD6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 23:58:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713Ab2ISD6L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 23:58:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E26EF98F9;
	Tue, 18 Sep 2012 23:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6X2+L5FA5Ro89LBIZFi1iC0vvpw=; b=gtwffW
	yhEZ4GCoxBy6eAwJmtJmaHH0ErOCLJQEErRacHgzVXrF+Tsg1PZrz9kzcbLRdXcg
	odOsNlXXwX46dULP6J1+mbksnFVnLmPvOH50TxNYQ3ZCAiJJLTZt98/La6LyBYQ2
	jsO0rFPKY90/rSMymFEDkp7enMS0lmY73k3DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SLyE/IlkbEb2/DZ9QuDNK+x+PgdY7j6i
	1NvYva17UudvNCZfZqO0N2X5xisvfzCjLRUXGX9LW6oCkiLOHymJMGRlxuCjNbNA
	0v+xx3rSrMEXFKY8JjQkR502jkFGaq+0sQFZuk36rB/IjZLOoevtfthH+Y63qMI3
	zyi+qwU1P1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDE4098F8;
	Tue, 18 Sep 2012 23:58:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A820F98F7; Tue, 18 Sep 2012
 23:58:08 -0400 (EDT)
In-Reply-To: <1348010734-664-8-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Wed, 19 Sep 2012 00:25:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3932A67C-020E-11E2-9826-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205905>

Philip Oakley <philipoakley@iee.org> writes:

> 'git clean' is controlled by gitignore. Provide See Also link for it.
>
> Use of core.excludesfile is implied.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>

Thanks.
