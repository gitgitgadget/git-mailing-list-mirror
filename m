From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull git-po master branch
Date: Tue, 01 May 2012 22:17:04 -0700
Message-ID: <7vbom7jh67.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 07:17:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPRwA-0001bn-BF
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 07:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab2EBFRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 01:17:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab2EBFRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 01:17:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 212448D78;
	Wed,  2 May 2012 01:17:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=tD3JIMXOIAmoXib6HKOadlTammY=; b=l5v7j4gu01dJBOwBIn6T
	tzLxvbP3RUFA6R9Aw960/vRhW8aei0m/mYh4W/7+qrfZb897mNNv3CHKTIt7igt3
	K08i+N8RvBCAZ0OQRWvfM17PdO0Osn0pruZV2pRB31qYXtigs/8X4TdnsrKfNynK
	vKOt4GeawI+vpOMkxlegMcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hJ9wPy1sb0cxIp8BuOo/OtD1u5qKID47oD/sRsVAvUeCTm
	x3MubyTXVRjhd9r3rCk5zMMxacNMzZ/vBbiwI6KvRbLKqYNOduEQmJ57kDQDcLCI
	YSZ9pAgJwvYTBIe93rLK89XeNQ5gGZTPfH3LlT5E2pLFlsa4pzUvWl6oS5LXg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 193968D77;
	Wed,  2 May 2012 01:17:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A50B78D76; Wed,  2 May 2012
 01:17:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0ED50EF8-9416-11E1-9304-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196785>

Both branches pulled; I found it somewhat iffy to *add* new language support
on the maintenance track, but decided to let it pass this time.

A new lang.po file is very unlikely to introduce regression to anybody
else, so it probably is OK.

Thanks.
