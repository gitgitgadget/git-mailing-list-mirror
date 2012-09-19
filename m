From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/8] Doc add: link gitignore
Date: Tue, 18 Sep 2012 20:57:17 -0700
Message-ID: <7vipbais0y.fsf@alter.siamese.dyndns.org>
References: <1348010734-664-7-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 05:57:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEBPk-0005d6-Q8
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 05:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab2ISD5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 23:57:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558Ab2ISD5T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 23:57:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED4F98C2;
	Tue, 18 Sep 2012 23:57:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SL8b0I/Moyx9s+p7LTBWnapXrTk=; b=nxjjHs
	HyluFMmGp8wVis6RRxQuBF6NxcPN87fheSqYl0jjp69DCOEy4PAHET8xZDj2PZUG
	t5FpIWG8gvoBdM2IUwdo5j9KjqBUfoDede2pCLkij9urwnD46mC/Mcc4EqfCZpN7
	fX8bc34QYm+JZKXxHkvcPlqEwF8mpEU8Lb2Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HxJGaf/4hMVlkw8Twsc0Tix7i3ZX1DYU
	D8yqkYnW9Qk7X5YeNCSsYH+DDruOKxlWRp6dR2EFtqWGYXbWHhjNH50FygEIQD0S
	aiM5IZe618vip5g4gZxi8Yp7xTzZ9Cu9bSaNUcZBHq0iN/rFB3ZrwJtVD64Zdvlh
	E+LtbEKBDT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D44F98C1;
	Tue, 18 Sep 2012 23:57:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCF8F98C0; Tue, 18 Sep 2012
 23:57:18 -0400 (EDT)
In-Reply-To: <1348010734-664-7-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Wed, 19 Sep 2012 00:25:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B7C44C6-020E-11E2-B289-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205904>

Philip Oakley <philipoakley@iee.org> writes:

> Use a gitignore link rather than the gitrepository-
> layout link.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>

Thanks.
