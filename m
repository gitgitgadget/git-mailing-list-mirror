From: Junio C Hamano <gitster@pobox.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
 custom merge strategy
Date: Mon, 28 Jul 2008 13:20:30 -0700
Message-ID: <7vljzlrca9.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
 <20080728185604.GA26322@sigill.intra.peff.net>
 <alpine.DEB.1.00.0807282008470.8986@racer>
 <7vproxrcvu.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0807281310j16b4ef5alf9738ec0f3270ba0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Jul 28 22:21:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNZDz-0003Qj-8s
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbYG1UUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbYG1UUl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:20:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbYG1UUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:20:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 151AC48413;
	Mon, 28 Jul 2008 16:20:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 351884840F; Mon, 28 Jul 2008 16:20:32 -0400 (EDT)
In-Reply-To: <bd6139dc0807281310j16b4ef5alf9738ec0f3270ba0@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon, 28 Jul 2008 22:10:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A4F2EAB4-5CE2-11DD-9DB5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90499>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Mon, Jul 28, 2008 at 22:07, Junio C Hamano <gitster@pobox.com> wrote:
>> That reminds me of:
>>
>>    http://thread.gmane.org/gmane.comp.version-control.git/89178
>>
>> to one of whose messages I sent a response today.
>
> Mhhh, but the proposed strategy there was in response to the 'insane'
> git-merge-theirs version, not to the 'exact opposite of
> git-merge-ours' that I refer to now, yes?

No.
