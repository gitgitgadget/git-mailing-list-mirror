From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Documentation style fixes
Date: Sat, 09 Jan 2010 23:12:44 -0800
Message-ID: <7vskaecu1f.fsf@alter.siamese.dyndns.org>
References: <7vaawp4wvz.fsf@alter.siamese.dyndns.org>
 <cover.1263081032.git.trast@student.ethz.ch>
 <201001100107.29920.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 10 08:14:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTs07-0002Y2-D0
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 08:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab0AJHMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 02:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685Ab0AJHMz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 02:12:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0AJHMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 02:12:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E46558F6D8;
	Sun, 10 Jan 2010 02:12:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JySqQE3KM8QjhcBrtKrP5UGx/I8=; b=YwY11a
	Vk4IdVnQW+E0LmuHCl2vXIRL89QQysOsaGa6OnYPO16/kgJFPGvHhk1E56aEKtxs
	D7J3DSqGkfhn1C5Sb0TRYctWjU/UBWLdV7P2UOmxFFWkLHdANYM8+rktEKAwP9EX
	vbZK5UVY5C79KvRbVI/wDpps/uA+21QOwYKCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nTqyTnB/8SfrNHyQTMOz2cMEdwOqzH/J
	lua2bD80Osrz3K06cHgTz/aq0A2D7Zwodav/B0o/2gnNscFa7qIxB2sit/JBhlZU
	Eav/fmSpOu1UIDejRmyGOXwvjfTQwpncaes8X6nMdZOfcmak5c52356S8frBSLzx
	vhyCfpdoOuI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB9068F6D7;
	Sun, 10 Jan 2010 02:12:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D436B8F6D6; Sun, 10 Jan
 2010 02:12:45 -0500 (EST)
In-Reply-To: <201001100107.29920.trast@student.ethz.ch> (Thomas Rast's
 message of "Sun\, 10 Jan 2010 01\:07\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 902214C6-FDB7-11DE-A0CA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136560>

Thomas Rast <trast@student.ethz.ch> writes:

> Turns out the fourth patch is over 200kB and can't be sent over the
> list.  I pushed the whole series to
>
>   git://repo.or.cz/git/sbeyer.git t/doc-merge-revamp

I think you meant s/sbeyer/trast/ ;-)
