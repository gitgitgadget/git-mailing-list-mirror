From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Consensus on "Git"
Date: Wed, 11 Nov 2009 01:36:45 -0800
Message-ID: <7vy6mdqu6q.fsf@alter.siamese.dyndns.org>
References: <ee77f5c20911110032r65a60653sfeef34e3de07d17e@mail.gmail.com>
 <7v8wedv3a3.fsf@alter.siamese.dyndns.org>
 <20091111092731.GA17422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 10:37:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N89dP-0000YJ-UW
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 10:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbZKKJgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 04:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbZKKJgw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 04:36:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbZKKJgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 04:36:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 237E87CE61;
	Wed, 11 Nov 2009 04:36:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ORKE9xf+ZC13XqMy8TuPcEN3VBs=; b=S+fsHH
	eyBtpeugoFyAxU8zTXozbk8A4Kc+OSkviOyMotDffAHfIMumxamyDFF2LT6PnxpY
	ggBa7Y6nul18J00X1Df088RR2x1yuuTbGJVxpKICyXIxyCAuoBn/SaXvsiJhGV9H
	m6QvaZKJsTHdLWg0ghQ4Yx04PcyAS+0q4IMT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=era2bkZ8RhBTQpDucb7FXabHZrHKiMv4
	zgoR2iQhGwgQgr/qaAL9yEUR+XVsK42m6lxhiaIv3IrfaAhrmieAGbx9LG+4ps0X
	8gQi7eynjb40eFFaJgPYkAp2qXzv+2ExtaeZGTMZrGCzO6yR7iJFFZyDCnqCLNKL
	JYEq0/MWHo0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2CCF7CE60;
	Wed, 11 Nov 2009 04:36:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EB567CE5F; Wed, 11 Nov
 2009 04:36:46 -0500 (EST)
In-Reply-To: <20091111092731.GA17422@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 11 Nov 2009 04\:27\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BDEC75CC-CEA5-11DE-88D2-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132632>

Jeff King <peff@peff.net> writes:

> Except for the title of every set of release notes, which all start
> with:
>
>   GIT vX.Y.Z Release Notes
>
> ? :)

Yeah these were copied from release to release and I do not pay much
attention to the minute details of how my tools I wrote long time ago
spells things ;-)

Perhaps I should update my scripts to generate them.
