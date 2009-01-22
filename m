From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cygwin: Convert paths for html help from posix to
 windows
Date: Thu, 22 Jan 2009 09:25:33 -0800
Message-ID: <7veiyv6ynm.fsf@gitster.siamese.dyndns.org>
References: <20090122171605.GA16684@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jaeckel@stzedn.de, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ3Kc-0004qB-2C
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 18:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZAVRZl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 12:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbZAVRZl
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 12:25:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbZAVRZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 12:25:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D207C92C27;
	Thu, 22 Jan 2009 12:25:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7D16692C26; Thu,
 22 Jan 2009 12:25:35 -0500 (EST)
In-Reply-To: <20090122171605.GA16684@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Thu, 22 Jan 2009 18:16:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B073A844-E8A9-11DD-B085-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106775>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> OK, I don't really know if this is the right way to do it. Maybe when
> the browser was built for cygwin this breaks? I have no clue,...

It might be simple enough to check if all it takes is to install a
prepackaged browser from Cygwin suite and try to run it.  Doesn't Cygwi=
n
have small ones such as lynx (or links)?
