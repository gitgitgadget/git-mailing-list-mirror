From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-show-ref: fix escaping in asciidoc source
Date: Wed, 19 Oct 2011 12:43:55 -0700
Message-ID: <7v1uu8dax0.fsf@alter.siamese.dyndns.org>
References: <1319050336-24717-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 19 21:44:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGc3X-0004Xx-2g
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 21:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab1JSTn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 15:43:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab1JSTn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 15:43:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6DE55D4F;
	Wed, 19 Oct 2011 15:43:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=kpROCm
	c/UpQ74IHzGFi9ZEJ0o6JZHPDK2M4ew8hEXkB/LvKqNNfm0K+mMOd31SMAQckl8E
	/wwS320k7tSYOBO4GpRn1D2/4g8LeWJA6TROQOvsiKjw99FIgaAb2hbCZp5RRbmj
	3aATLRsd3ziRdrrnioVgWqVSQ9l8hT2ZRx/zY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IbiUTJbpaaeUbyM7q2hOWMtUGE1bw1SI
	mHdgYK6GTxL1nRi3WiB+5VyrxB5U9dFZW4PHt/HLwC7h/nb6rCIiaqC+3mU78gzV
	3x3q8umZtHhTkFj6C74VHTkdIvQKnDex1Ajzm4VIgU2wi53BzHjvu9u6V/iksp0k
	wEpkeYKpVeE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D191F5D4E;
	Wed, 19 Oct 2011 15:43:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5861D5D4C; Wed, 19 Oct 2011
 15:43:57 -0400 (EDT)
In-Reply-To: <1319050336-24717-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Wed, 19 Oct 2011 20:52:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF3FC9EE-FA8A-11E0-88E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183945>

Thanks.
