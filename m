From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] t9402: Use TABs for indentation
Date: Sun, 09 Dec 2012 01:43:35 -0800
Message-ID: <7v4njvef20.fsf@alter.siamese.dyndns.org>
References: <201212082235.54386.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mmogilvi_git@miniinfo.net
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 09 10:43:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThdQT-000122-Ub
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 10:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803Ab2LIJnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2012 04:43:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932796Ab2LIJni convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Dec 2012 04:43:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE1888416;
	Sun,  9 Dec 2012 04:43:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nbKgh1Ur5YHS
	pkGhqT0Y2vqK5oU=; b=Xoa2fQivxUHQX/ugufe265TGJxzUoNPAs/9UFJFpV6BH
	Y1qge/jRFbMEgXu9FSvZabtoN+NGU0JB9knx/32cR9J2Q2rra1gsPh3uTuA4BqrG
	k4f/ia9ZM878IH0GB8LVg2xqEo7vCOmYQQy9MepLQ4LT70d19ZSpQmyzXH6JgxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=opwkP0
	rjbI8G0Wc1H4ZIxFm1yOCIa0/T5EUO655RfCyYzH8aG4kwK05n4hq/ZBoepUB205
	ghoylnvIk+V2GSdIVOmPljuUdfvmGxszOLced9TJpl+cLFBT3FewRb1ffbBpbg5Y
	TlX1tdkB3aSpf2pJAIbYUArCMvrCfS8Dh+8zk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD26E8415;
	Sun,  9 Dec 2012 04:43:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B7688414; Sun,  9 Dec 2012
 04:43:37 -0500 (EST)
In-Reply-To: <201212082235.54386.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sat, 8 Dec 2012 22:35:53
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7EB027A-41E4-11E2-BD11-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211231>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Use TAB's for indentation
> Put the closing ' at the begin of the line
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

The entire series looked cleanly done.  I've tweaked the last patch
a bit to wrap overlong lines, though.

Thanks.
