From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-mailinfo: fix typo
Date: Wed, 11 May 2016 14:35:22 -0700
Message-ID: <xmqq7ff0jn1h.fsf@gitster.mtv.corp.google.com>
References: <1462999375-27664-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed May 11 23:35:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0bn0-0006QE-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 23:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbcEKVf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 17:35:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751391AbcEKVf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 17:35:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D05381B067;
	Wed, 11 May 2016 17:35:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=OAnyjx
	GCorotBxdDtqHWflmZ7fZIUxTb9R8yyCO4vLKDC9zlDmEfxdnxlm9HKGkbj+vwQH
	RvvPZbd9FehKGHH2WB4TtbxnUxSw/pdIEycwSBWVE63YumJy5XHBb7XhdEuQDFg1
	nwAFOCA5ZeGL5HGbnh9olrwK9YUbkp7K87vhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yYG92OBa2ap/6ji4F0Iim6e+PgCEZZP+
	003U8ZWunU38F0R/yxEzXZPBOaPwX5JeS5aMxhzInTcuEg+f+x0h3nWcrJlQHQO7
	wY5hAuG/z5vVOC7cjg3gL1nVvGXD0ZARATjkDVNkTNkObBWTrwPeVqnR+QD8Z0G4
	9a+GoxroT0s=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C763E1B066;
	Wed, 11 May 2016 17:35:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48FC21B064;
	Wed, 11 May 2016 17:35:24 -0400 (EDT)
In-Reply-To: <1462999375-27664-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Wed, 11 May 2016 20:42:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 452CC770-17C0-11E6-9FFD-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294369>

Thanks.
