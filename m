From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix typos in comments
Date: Sun, 21 Jul 2013 15:32:53 -0700
Message-ID: <7vtxjnr1be.fsf@alter.siamese.dyndns.org>
References: <20130720190707.GA30044@domone> <20130720191311.GB30044@domone>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Jul 22 00:33:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V12BY-00064z-VK
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 00:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab3GUWc5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jul 2013 18:32:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab3GUWc4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jul 2013 18:32:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF1232064;
	Sun, 21 Jul 2013 22:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LRMU33JrONaG
	aa3WCiOx75ga+6M=; b=pixxJtlwjBH3Ljoq89RMC4b+7nIlygE+q+JpaAHS+4pb
	Skw0Tgu87tRjyfB75PKfvfH0pVDVnTgbdnyq+WgKPb4Xn95ooGEzlCquJVCuQuZJ
	aGJgHi18H9YxRqZQFKbVJAkKvlqAcT2+ryEvASoskMcC12Um5dOwZW5x1D9vGok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LGsngB
	/MAtZpeKivT0KXtGX2rmqUIAcDHJFpV/oXQvVFJ1qt4FfkgPnwtVz3MFeQVnUAAc
	4/yiobX62jMl1t64zlnE3nHbsZ3jVNrub9+biO78k697/SOI3Iwkw6MB7vuMamNa
	rXkOoDZD8DEwVuoMS1Y7QlEJwsBXVwhOhZsWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31F1032063;
	Sun, 21 Jul 2013 22:32:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA3B33205F;
	Sun, 21 Jul 2013 22:32:54 +0000 (UTC)
In-Reply-To: <20130720191311.GB30044@domone> (=?utf-8?Q?=22Ond=C5=99ej_B?=
 =?utf-8?Q?=C3=ADlka=22's?= message of
	"Sat, 20 Jul 2013 21:13:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CF40292-F255-11E2-8C38-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230948>

Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> writes:

> A dictionary that I generated is following, patch is below.

Please use only "obvious and clear typo nobody would disagree with
the fix" entries and drop other entries in the "I would prefer to
use a different phrasing or spelling" category.  For example, as
already mentioned, "alloted" is a proper pp of a verb, so it falls
into the latter.

Thanks.
