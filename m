From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Release candidate period
Date: Sat, 19 Sep 2009 18:17:37 -0700
Message-ID: <7vab0q76tq.fsf@alter.siamese.dyndns.org>
References: <a4c8a6d00909191644n131667f2uc7e59d0d56749c42@mail.gmail.com>
 <alpine.LFD.2.00.0909192043060.24133@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 20 03:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpB41-00042Q-BP
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 03:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbZITBRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 21:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbZITBRs
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 21:17:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZITBRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 21:17:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 738C0578DF;
	Sat, 19 Sep 2009 21:17:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bHsjSqox/iDhOViL5GP9vJLv1kc=; b=GnBu7V
	EIVYR1uk/2FzIxt4ZCEmJ+lw6RpdxZ79x0f299wzVjw5n35tofFX8shVhjrhRHWD
	oqd/BM7fyjuj1NjnWkb8SnVO4UqyETFMG2ekt4dRmQKva9JTPCtQbnX3sVw78rmL
	POfxYORQIcZJFB4HP9N7HoP4Itq8JHRLLqCtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e6NPMDFTfajX2RikOQfesos2QRgOUiyv
	1FyzqoHbr2/2U9s11n4ZaA7jGeevz2NGuXXLR4IRvfVJcde3MVgPGx9sab5+TJ5i
	ZpKu/vrsb+wjDoVb9PlWJMdQHQ+D8z3I1uEJO9sYt18oTn1qQ47shEHO6MCgqWnK
	U6bIrwv6y48=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B6E3578DE;
	Sat, 19 Sep 2009 21:17:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B583B578DD; Sat, 19 Sep 2009
 21:17:39 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0909192043060.24133@xanadu.home> (Nicolas
 Pitre's message of "Sat\, 19 Sep 2009 20\:56\:38 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 680C52F8-A583-11DE-91AF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128833>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Sat, 19 Sep 2009, Thiago Farina wrote:
>
>> Hi Junio, I saw that you committed two of my trivial patches with your changes.
>> 
>> Thank you for committing my patches.
>> 
>> I have one more trivial patch that I want to send, but we are in -rc
>> freeze, when I can send it?
>> The release candidate period is not defined, no? The period ends so
>> when the mailing list reaches an agreement and agrees that the release
>> candidate is ready?
>
> This is a benevolent dictatorship.  Junio sets the date.

True.

And Thiago, don't thank me.  It's not "hey I now have N commits in a high
profile project" game.  We are all working together to make it better, and
we thank you for your attention of detail.
