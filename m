From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL REQUEST]: Please pull git-gui
Date: Wed, 17 Oct 2012 16:00:27 -0700
Message-ID: <7vobk0n1pw.fsf@alter.siamese.dyndns.org>
References: <87d30gzqvv.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 01:00:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOcbS-00048N-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 01:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab2JQXAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 19:00:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62701 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab2JQXAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 19:00:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B26AF976A;
	Wed, 17 Oct 2012 19:00:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y9+X2borWE/JIHNghXHzqMKPCO0=; b=LI1E4Y
	6A5Lw4mD1Q/PbyW+LWhdJ4/kQ9oIlhEcX45U4fMU9ezgCPoLXWpBp2lkaN5v8TkL
	uDdyvCiAV5PJC8oiJcDYiZsCRhC40TFqhaLF+puzphd58XVPgMfsuRp/iGPQ3DjR
	qUDbLJXGodlwzfidkGTsNLjJL7Dux3FLuyaRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLtiAvv8NY22NU9ABclgWJk9To90+5vE
	+cC0v8MvXzC9Daf4H8rF0zD2PaCKyP0aV6Tj5CHlDR1ZWzez8d1WSYZb1SRYza3Y
	hO0sOJmXnw8AWcM14+TRTh7tiVC02XlgqDOqJ6KOGti+x7UUpsZJuhrK5ejbjW5b
	uKMcrL2vtNg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A016D9768;
	Wed, 17 Oct 2012 19:00:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C2329767; Wed, 17 Oct 2012
 19:00:29 -0400 (EDT)
In-Reply-To: <87d30gzqvv.fsf@fox.patthoyts.tk> (Pat Thoyts's message of "Wed,
 17 Oct 2012 23:16:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7214E282-18AE-11E2-A61C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207947>

Thanks; will pull.
