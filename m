From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitignore: add test-mktemp to ignore list
Date: Sun, 13 Feb 2011 15:15:42 -0800
Message-ID: <7vvd0nv84h.fsf@alter.siamese.dyndns.org>
References: <1297552877-25651-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Arnout Engelen <arnouten@bzzt.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 00:15:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PolAb-00081p-Gt
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 00:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228Ab1BMXPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 18:15:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab1BMXPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 18:15:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 636C23E48;
	Sun, 13 Feb 2011 18:16:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RuN9xTKDvBjIK4Wvx6hQWnF6z9Q=; b=ASkrHI
	a9kOxkF0thQwJTX9wSkIEayY/lZN8ii1EqCmloewQ1HvEJkd6jbfr/EOnTqNwlBy
	ngDdH20VMEegiaflcJSzo22aq1NvZlXOeWqCyjNnMVqXqVtfOPzDIPcjvNg4lC+Y
	g+4ufPENlye/DdGUklkMSdHkGdyCHuTsUVVkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QoBHK7Q4+Ua0u7k6jnCIRc5QbpIltu28
	BiemR6x5/kx7PGR1rjaO8eTAELy+il0z7zxEy4rCKfu053A+ez4zDTMY5WjK5K+c
	+tpGRxqXR/5wh23MRBlG2VZDlPhV6KbUA2Scmshp5c0EVzJz9E/iQ3vdoJWG4MZt
	rNqLFQb11R4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3238C3E43;
	Sun, 13 Feb 2011 18:16:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C99D3E42; Sun, 13 Feb 2011
 18:16:48 -0500 (EST)
In-Reply-To: <1297552877-25651-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat\, 12 Feb
 2011 23\:21\:17 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57C30C7A-37C7-11E0-A1E3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166682>

Thanks; applied.
