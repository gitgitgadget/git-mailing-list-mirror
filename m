From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Stopping those fat "What's cooking in git.git" threads
Date: Sun, 20 Jul 2008 21:24:02 -0700
Message-ID: <7vprp7yie5.fsf@gitster.siamese.dyndns.org>
References: <20080720205125.GP10347@genesis.frugalware.org>
 <7vsku44679.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0807201550v27d6db3epd0d0b4bc663e0351@mail.gmail.com>
 <7v3am42lk2.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0807201619g6c268488kd6b45109a246638d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Jul 21 06:25:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKmxU-0007CX-Tx
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 06:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbYGUEYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 00:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYGUEYO
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 00:24:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYGUEYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 00:24:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AF9B035285;
	Mon, 21 Jul 2008 00:24:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DAD7635284; Mon, 21 Jul 2008 00:24:05 -0400 (EDT)
In-Reply-To: <bd6139dc0807201619g6c268488kd6b45109a246638d@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon, 21 Jul 2008 01:19:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DE85EAF8-56DC-11DD-9A23-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89298>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Mon, Jul 21, 2008 at 1:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> On Sun, Jul 20, 2008 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> I could make "What's cooking" not a follow-up to the previous issue, or
>>>> perhaps add "(volume 1.6.0, issue 28)" at the end of the Subject.
>>>
>>> The downside of this is that it'll be less easy to see the difference
>>> with the previous version.
>>
>> My vague recollection is that it was Pasky who complained long time ago
>> when "What's in" was not a follow-up to its previous round, which led me
>> to switch my workflow to send them in the current form.  You cannot
>> satisfy certain people no matter what you do.
>
> Add an interdiff at the bottom of the mail? You can't satisfy
> everybody no matter what you do, but you can come quite far, it
> usually means you have to do a lot of work to do so though.

Do you think I have an infinite bandwidth?  I don't.
