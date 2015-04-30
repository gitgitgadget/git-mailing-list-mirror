From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help with Getting started to Contribute
Date: Thu, 30 Apr 2015 09:38:57 -0700
Message-ID: <xmqqsibh1sgu.fsf@gitster.dls.corp.google.com>
References: <CAMOUyJ8_Xyw=a54VFdsJFrrxr86zA_W5--w5bpED70D4g3YY4w@mail.gmail.com>
	<553F9F77.3020007@gmail.com> <vpqoam54o5s.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: karthik nayak <karthik.188@gmail.com>,
	Tummala Dhanvi <dhanvicse@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 30 18:39:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnrUO-0005gq-JH
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 18:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbbD3QjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 12:39:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750710AbbD3Qi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 12:38:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BFE24DB27;
	Thu, 30 Apr 2015 12:38:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JfyA1KnhjY/cxSmh+82eYD9png8=; b=aQcDna
	gll0qNCNjR2mP+7VgXzfHCvHH89XJy7JzqaeJ9fEzOVluU+6ebwkjPS8qUZTSmEa
	zOQ3ksRfsHGEJ+j82pJcKa8ubi3oXZc/kasCxFE8GhTh+7YrjbQxOxMHrwXBDPOa
	azfOmXzgu0c8efQuks6NcM/x8RstWkmhWaOa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u3RI9+0C7+e+YOlF1uNy2y0t9ShUjQv2
	wopndqkmfLsyANuzLuYxEAa5vQH7G4HeK9zrdMuNmpXmxESedEXRNjfVMt7b8F9f
	9wUw7DybuFkjBx38AylLD4Yn0QiCd7YTXuJdZ415t/S7T1p4RtcVAN0TmQ+rN815
	RIBSbtV8n9Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4509B4DB26;
	Thu, 30 Apr 2015 12:38:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6C6B4DB25;
	Thu, 30 Apr 2015 12:38:58 -0400 (EDT)
In-Reply-To: <vpqoam54o5s.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	30 Apr 2015 17:43:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 666E1C8C-EF57-11E4-8A43-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268078>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> karthik nayak <karthik.188@gmail.com> writes:
>
>> There is also Junio's Blog where he keeps a list of things to be done
>>
>> http://git-blame.blogspot.de/p/leftover-bits.html
>
> I'd add this: https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

Thanks. I think the latter is much more appropriate as a list of
starter projects.
