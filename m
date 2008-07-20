From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Stopping those fat "What's cooking in git.git" threads
Date: Sun, 20 Jul 2008 16:16:45 -0700
Message-ID: <7v3am42lk2.fsf@gitster.siamese.dyndns.org>
References: <20080720205125.GP10347@genesis.frugalware.org>
 <7vsku44679.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0807201550v27d6db3epd0d0b4bc663e0351@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Jul 21 01:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKiA5-0005qF-CD
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 01:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbYGTXQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 19:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbYGTXQx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 19:16:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbYGTXQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 19:16:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C644737DA6;
	Sun, 20 Jul 2008 19:16:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4464F37DA5; Sun, 20 Jul 2008 19:16:47 -0400 (EDT)
In-Reply-To: <bd6139dc0807201550v27d6db3epd0d0b4bc663e0351@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon, 21 Jul 2008 00:50:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EF7B059E-56B1-11DD-A1CC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89263>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Sun, Jul 20, 2008 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I could make "What's cooking" not a follow-up to the previous issue, or
>> perhaps add "(volume 1.6.0, issue 28)" at the end of the Subject.
>
> The downside of this is that it'll be less easy to see the difference
> with the previous version.

My vague recollection is that it was Pasky who complained long time ago
when "What's in" was not a follow-up to its previous round, which led me
to switch my workflow to send them in the current form.  You cannot
satisfy certain people no matter what you do.
