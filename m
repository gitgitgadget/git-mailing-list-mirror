From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dead link
Date: Sun, 21 Jul 2013 15:33:57 -0700
Message-ID: <7vppubr19m.fsf@alter.siamese.dyndns.org>
References: <20130720192238.GA30833@domone>
	<CALkWK0ktWTcgNSjTtkjJ5ogjE5YAVRdq+HZpQ51-DFObsCjQrQ@mail.gmail.com>
	<20130720194655.GA30946@domone>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Jul 22 00:34:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V12Cc-0006f7-13
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 00:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab3GUWeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 18:34:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab3GUWeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 18:34:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1D37320ED;
	Sun, 21 Jul 2013 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wZk/3Q9CSVlO5KUMtxj5eUmONGw=; b=O+l/dX
	+7svFERGk4dw2Zdmw6KXhj2GtNs/RCvE7nWu2d3z6pjY3h6cddBe1/LiAHeX/p4I
	k9HVJFOWKHH96serhOmffkHVs/vzfrgZpy+FG2rxwO5U5wTGXkgWlOrtDvFYCU4a
	C796F0J82DVdAel3U7p1Ka6+TSAfGZdjDCAzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iwutjn2vcka61/3gT8/gcBdyJJXssuw1
	9oUYJWaLJvuZBI5h/kPzzyFMkkUpg6PuLbbVQwqFZU/brHWGYIR7wYjeTxU8oKLr
	i2Kp1Aab9giQpeaarqBYB+vx5IRSj//mbt7819H/OcsIGFbpHPnuv9SxwOhjTqIK
	3yZA6f6Ces0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98B37320EC;
	Sun, 21 Jul 2013 22:33:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EACA320EB;
	Sun, 21 Jul 2013 22:33:58 +0000 (UTC)
In-Reply-To: <20130720194655.GA30946@domone> (=?utf-8?Q?=22Ond=C5=99ej_B?=
 =?utf-8?Q?=C3=ADlka=22's?= message of
	"Sat, 20 Jul 2013 21:46:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2B8CFDA-F255-11E2-8430-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230949>

Thanks; the patch seems to cover all the instances.

Sign off?
