From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify information about 'ident'
 attribute
Date: Thu, 30 Oct 2008 12:30:23 -0700
Message-ID: <7vfxmdev8w.fsf@gitster.siamese.dyndns.org>
References: <20081030191433.710aff11@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Thu Oct 30 20:32:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvdFZ-0001yw-F9
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 20:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbYJ3Tan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2008 15:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbYJ3Tan
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 15:30:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYJ3Tam convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2008 15:30:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CF675765AE;
	Thu, 30 Oct 2008 15:30:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9F574765A6; Thu, 30 Oct 2008 15:30:30 -0400 (EDT)
In-Reply-To: <20081030191433.710aff11@perceptron> (Jan =?utf-8?Q?Kr=C3=BCg?=
 =?utf-8?Q?er's?= message of "Thu, 30 Oct 2008 19:14:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3AE72934-A6B9-11DD-BAC4-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99523>

"Jan Kr=C3=BCger" <jk@jk.gs> writes:

> The documentation spoke of the attribute being set "to" a path; this =
can
> mistakenly be interpreted as "the attribute needs to have its value s=
et to
> some kind of path". This clarifies things (and also calls the object =
ID a
> hash rather than a name because that might be confusing too).

I'd agree with the first change, but not with the second.  "object name=
"
has been the official name of these hexadecimal thingy for a long time
(see the glossary).
