From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Thu, 10 Jul 2008 12:08:51 -0700
Message-ID: <7vk5ftpnek.fsf@gitster.siamese.dyndns.org>
References: <200807102057.15063.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 21:11:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH1Xz-0008CH-Rn
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 21:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbYGJTJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 15:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754380AbYGJTJO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 15:09:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbYGJTJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 15:09:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C6F1325A0A;
	Thu, 10 Jul 2008 15:09:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 917E925A09; Thu, 10 Jul 2008 15:09:04 -0400 (EDT)
In-Reply-To: <200807102057.15063.toralf.foerster@gmx.de> (Toralf
 =?utf-8?Q?F=C3=B6rster's?= message of "Thu, 10 Jul 2008 20:57:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD819B0E-4EB3-11DD-942C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87998>

Toralf F=C3=B6rster <toralf.foerster@gmx.de> writes:

> git-describe gives an informative string about the current status:
> tfoerste@n22 ~/devel/linux-2.6 $ git describe
> v2.6.26-rc9-56-g6329d30
>
> I appended those strings to the names of my UML kernel executables.
> Unfortunately I didn't used the commit id and now I'm wondering wheth=
er git
> could accept v2.6.26-rc9-56 as well in future.

It does take v2.6.26-rc9-56-g6329d30.

It will never take v2.6.26-rc9-56.  The world is not linear.
