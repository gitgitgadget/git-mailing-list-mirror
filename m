From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Advertising the Git User's Survey 2010 - report
Date: Fri, 01 Oct 2010 16:13:44 -0700
Message-ID: <7vvd5lfqvr.fsf@alter.siamese.dyndns.org>
References: <AANLkTim1mLhQnJPT9KiinR4L3C=O9L=V9M3X9x7Cr+oC@mail.gmail.com>
 <201009222242.06975.jnareb@gmail.com> <201009301251.37878.jnareb@gmail.com>
 <AANLkTikS0=FxcbSFbZpU0gtD8Md64RGBsn394sq3dewC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 01:14:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1oni-00008E-GM
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 01:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab0JAXN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 19:13:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab0JAXN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 19:13:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5578DDB27D;
	Fri,  1 Oct 2010 19:13:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ByES6iOZ+/NbrxQ5FqO5EoNeHr8=; b=aGTcUI
	SqSmtb3CeYhsBvx1G8BgLNiWW/HCpRHWO3LvbAxny90TsCL0UcLUkpEBHoZmGbh2
	4M+dUsy+vcJYRw1gRf0Upajr+dWmLUvSQJuircSq4J0q1Gvo3U9Apf/Hf2+Szc/k
	aV2dUOqpjkW+CpK+mqGaHiI1UZ2eaNmtR7j4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VuJTBfsffUpLeOqAlxS8bRMGOV5R7ugZ
	q8v/W+oOIPvCW08pjvCpuKOSvHvK6USQ4LmLavgxi3qG07Y00K6uSCalo13vTLqG
	utGSiM6pt6XkyVKT7xobVY0FW695dTeYtxE/Sc8E+8PqcvUullTiCGeNZ1QekhhE
	QpY831S7LAY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 100F9DB27C;
	Fri,  1 Oct 2010 19:13:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F72ADB27B; Fri,  1 Oct
 2010 19:13:46 -0400 (EDT)
In-Reply-To: <AANLkTikS0=FxcbSFbZpU0gtD8Md64RGBsn394sq3dewC@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 1 Oct 2010 21\:05\:00 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8D721E04-CDB1-11DF-870A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157787>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On 9/30/10, Jakub Narebski <jnareb@gmail.com> wrote:
>>  Are there channels that should be utilized missing from the above list?
>>  How next year Git User's Survey 2011 (if there would be one) should be
>>  announced?
>
> From the report, 77% answers question 21 as "this is my first survey",
> I think you have done a fantastic job.

That, or (more likely) these people have started to seriously look at git
within the past year.  There doesn't seem to be a more direct "How long
have you been using git?" question, but look at #22 as a proxy.  54% of
the people answer they cannot compare the current version of git and the
one from one year ago.
