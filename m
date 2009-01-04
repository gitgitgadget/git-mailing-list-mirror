From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sun, 04 Jan 2009 02:01:21 -0800
Message-ID: <7vocynz8y6.fsf@gitster.siamese.dyndns.org>
References: <1230338961.8363.101.camel@ubuntu.ubuntu-domain>
 <200812280024.59096.markus.heidelberg@web.de>
 <4956C47B.4020602@lsrfire.ath.cx> <49594C16.2010406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 04 11:03:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJPp9-0001V7-56
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 11:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbZADKB3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 05:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbZADKB3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 05:01:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbZADKB2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 05:01:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E84758DDD6;
	Sun,  4 Jan 2009 05:01:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2A3E48DDD5; Sun,
  4 Jan 2009 05:01:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A6A51D32-DA46-11DD-9FC7-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104503>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> It's unchanged since it has it's own commit message parser.
>
> ... which displays the first line of the commit message, unlike
> --pretty=3Doneline.  Here's a quick fix.  I probably won't have time
> to come up with something prettier this year.

I think the code is pretty enough ;-)  I just need to come up with a pa=
tch
description and forge your Sign-off.

Thanks.
