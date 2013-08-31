From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] branch: trivial style fix
Date: Fri, 30 Aug 2013 20:36:29 -0700
Message-ID: <xmqqli3iwmyq.fsf@gitster.dls.corp.google.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 05:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFbzI-0003NX-SJ
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 05:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab3HaDgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 23:36:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab3HaDgc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 23:36:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D77EF33750;
	Sat, 31 Aug 2013 03:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hoQuBTw7qnmlO+S1IYnCSQ7gWh4=; b=a5AoC1
	jnfqMdvQoKlGFnKPwJBd/ulQGufY9GJj/eltSzioilJaS2IwQ/U52goPmOLrFET9
	bu+RYubePQowYuEVnWls8aj1mh6AT0Bvc9eIjCYn8H2H+8ZQz5y3umACkwyppY6s
	sYtZgsMDmfOI55TwE7dPJy3cRNPzHI1qXekgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VfQ4FnCmzLKLHGShuBBxpnFRoWO1DzHA
	KnLuW0homy58tupeqXp1pp4DbX0MlFNEWT5vGOFGZLjdZFucXmTuvjSnQ0hw4x2L
	iZmZCTydBiGx5j30M0nUHindEupbB2SvHd3WEvLjoYXmy/r8ZYkoYftwM68ot/W8
	la6ljfe/xG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD9B43374F;
	Sat, 31 Aug 2013 03:36:31 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C4973374D;
	Sat, 31 Aug 2013 03:36:31 +0000 (UTC)
In-Reply-To: <1377899810-1818-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 16:56:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86CA752C-11EE-11E3-8960-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233494>

Good.  Thanks.
