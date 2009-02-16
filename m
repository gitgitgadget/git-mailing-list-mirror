From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Mon, 16 Feb 2009 00:49:52 -0800
Message-ID: <7viqnabwb3.fsf@gitster.siamese.dyndns.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
 <20090216080432.GA16453@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 09:51:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYzCR-0005NO-MO
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 09:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbZBPIuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 03:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756507AbZBPIuG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 03:50:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756390AbZBPIuE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 03:50:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A671F9AEBC;
	Mon, 16 Feb 2009 03:50:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D7959AEB9; Mon,
 16 Feb 2009 03:49:55 -0500 (EST)
In-Reply-To: <20090216080432.GA16453@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Mon, 16 Feb 2009 09:04:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CAFFD10E-FC06-11DD-AD96-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110147>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> How about having the default in the code being a warning, but the
> default for new repos being "reject"?

To reserve time to manage git itself, I will try not to point people to
previous discussions, but I'd like help from people who've already seen
the previous discussions to do so.  This is one of the things that was
proposed and already shot down.
