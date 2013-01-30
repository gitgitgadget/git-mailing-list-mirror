From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Anybody know a website with up-to-date git documentation?
Date: Wed, 30 Jan 2013 08:46:51 -0800
Message-ID: <7vtxpylitg.fsf@alter.siamese.dyndns.org>
References: <D6EAC791-63E2-4B0E-92AA-676112039BD9@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 30 17:47:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0aof-0005LP-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 17:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab3A3Qqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 11:46:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331Ab3A3Qqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 11:46:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D3ADB38F;
	Wed, 30 Jan 2013 11:46:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HVikve52w4wEfWmW/5OfM1Udjbs=; b=At7nqB
	/gmcA4m7DHXDn5Y2ngjb5seKYUlbP0TiEwCIApizLEI4vAZGM5WpmZZoxbiM4JQj
	YGAo2++7YkVXrITomDrNe/aoGUze/uZ4jO6qVMlGIXaTZoT8gn/a/EKXCJy38tuv
	hraRbLP/fHI9WBon4K0Y9o2rVBwOXYLFNeCvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rim99lyHnr76SPPuXbDnyLU/G9e/PubB
	YuhtlH2U4REXg81Pv7BV7WIZ4rvsamnhVsme1+9XPOH/X4Apf/1csnVgfFWRQle6
	UY6qvxfNSTisERrTGuUj8EeG1y3GO2UFmGb1T6bvbdC8UaSVg6S5LAEfJbyNCKtu
	CsvmxShM2y0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91CB1B38E;
	Wed, 30 Jan 2013 11:46:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16898B38B; Wed, 30 Jan 2013
 11:46:52 -0500 (EST)
In-Reply-To: <D6EAC791-63E2-4B0E-92AA-676112039BD9@quendi.de> (Max Horn's
 message of "Wed, 30 Jan 2013 12:46:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A66D0E9C-6AFC-11E2-BB18-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215030>

Max Horn <max@quendi.de> writes:

> does anybody know a website where one can view that latest git
> documentation? Here, "latest" means "latest release" (though being
> also able to access it for "next" would of course be a nice bonus,
> likewise for older versions).

Preformatted ones for the tip of 'master' are reachable from

    http://git-htmldocs.googlecode.com/git/git.html
