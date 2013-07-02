From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/5] Reroll patches against Git v1.8.3.2
Date: Tue, 02 Jul 2013 12:41:03 -0700
Message-ID: <7vbo6klpgw.fsf@alter.siamese.dyndns.org>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com>
	<cover.1372719264.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 21:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu6Rz-0002Ya-LY
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 21:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab3GBTlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 15:41:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756242Ab3GBTlG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 15:41:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF4AC2A3CD;
	Tue,  2 Jul 2013 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8CqpM0MCZ2WUFixMGZ7D4Q4T/kM=; b=G8/G5l
	V+U+0HCYg8Iu+iztbCQ2nTRu+NrO4z5XJw/rxhmucyyolDPJHj3OXQB3EbDHqSHK
	lTSlouX6YAAaG5XWkGKk8XmVUZNIACnu/7566DPP8sllYTcshElYuGncCdkA5uAq
	GZEDwBprxetb7Iupero6CsTHVwHXYz3/XZ8WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cX4XXasjPPJWmCdd7S6zSxCL8PS4tQ9j
	YMz6ybe0HS9Ki9kds2CopxLgcYYGgshVOlCHT9P8apHBYl+IMiM9gdHvKwj1nbeq
	KqnAcagYBqVdAEs+KA8Ep6b8Scynpl5MtjUoIBtuEVNCUH1KAkDYIUiYatejtxED
	k8Ez7K6cF60=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E48612A3CB;
	Tue,  2 Jul 2013 19:41:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65BAD2A3CA;
	Tue,  2 Jul 2013 19:41:05 +0000 (UTC)
In-Reply-To: <cover.1372719264.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's
	message of "Tue, 2 Jul 2013 03:18:59 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55B2F1DA-E34F-11E2-9CEA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229421>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

> v8 of this patch series includes the following changes against v7:

Oops, isn't this already in 'next'?  In that case, please feed
incremental updates on top of the patches that are already queued as
improvements and fixes.

Thanks.
