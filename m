From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] wildmatch series update
Date: Thu, 27 Sep 2012 11:08:23 -0700
Message-ID: <7vfw63qqy0.fsf@alter.siamese.dyndns.org>
References: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:08:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THIVo-0007Vq-Fi
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 20:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab2I0SI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 14:08:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab2I0SI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 14:08:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D469A8453;
	Thu, 27 Sep 2012 14:08:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rLlLuxcX5hHsdcUgJC2LSkiQVOM=; b=evfnds
	P6xbwN0ZDyZBx/8OOYENZWuoOskWuWNbgwzgvW+Cpsh4kpz7QDk58/W6wkFQlmVq
	JTy0a3VA8uE0xKsNyCKNHcJhaUm9qyZF8EGTaWnRTu4CbleB0v2AV22fy4b6/o3/
	ltzUIYi3837kgSLjKyudDOakWVqP6liPsFxy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CmRzihgKuPRDJd2aNNxZ7sP+GCMr7ex+
	zodCji598iaI7wVQq7RsWiXAjlRKUL3Io8efak6349s7vnNvmS19dhyRRk+qnoTt
	i8pUlFihlkooPy5b5grTVfbpUerNmpreVXdgp7t1M3133wsasARXJZexbbtXJW7v
	+zupd5ROjEM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C37408452;
	Thu, 27 Sep 2012 14:08:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4735A8450; Thu, 27 Sep 2012
 14:08:25 -0400 (EDT)
In-Reply-To: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 26 Sep
 2012 18:25:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54C4942E-08CE-11E2-912B-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206500>

Thanks; will re-queue.
