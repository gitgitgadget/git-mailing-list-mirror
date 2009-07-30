From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typos on pt_BR/gittutorial.txt translation
Date: Thu, 30 Jul 2009 12:47:00 -0700
Message-ID: <7viqhaar7v.fsf@alter.siamese.dyndns.org>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com>
 <20090730145044.GA1727@vespa.holoscopio.com>
 <4A71C6A7.80008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	=?utf-8?Q?Andr=C3=A9?= Goddard Rosa <andre.goddard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 30 21:47:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWbav-0005hd-SL
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 21:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbZG3TrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 15:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbZG3TrK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 15:47:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbZG3TrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 15:47:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 09BA51A3C5;
	Thu, 30 Jul 2009 15:47:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2B1641A3C2; Thu,
 30 Jul 2009 15:47:02 -0400 (EDT)
In-Reply-To: <4A71C6A7.80008@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu\, 30 Jul 2009 18\:13\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3E01CF0-7D41-11DE-9A3F-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124480>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Isn't it more like "kernel of linux", which is pretty OK (at least in
> English)?

Google shows (in a query limited to Portuguese) 912000 hits for "kernel do
Linux" and 6550 hits for "o Linux kernel", so as Thadeu already said, it
appears to be not just "common", but "so common that practically nobody
uses the other form."

I do not know if there is a war between the factions that use these two
phrases in Portuguese speaking community, but this smells somewhat similar
to the "Is it Linux or GNU/Linux?" religious war.  GNU/Linux example might
be much more religious, as opposed to a lingusitc disagreement Thadeu's
comment suggests the Portuguese situation is, though.

Be it religious or linguistic, I'd rather not to see the war fought in our
documentation.  The documentation is not about the Linux kernel to begin
with, and being easier to read and understand by using phrases more
familiar to the readers is much more important than being technically and
linguistically correct but risking to make novices stutter while reading
due to uncommon wording.
