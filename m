From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve English grammar
Date: Tue, 02 Sep 2014 11:53:32 -0700
Message-ID: <xmqqa96h26s3.fsf@gitster.dls.corp.google.com>
References: <20140830135601.0f9fce66fe68968f56bd2879@gmail.com>
	<CALKQrgdd588+-L2QB1LixQfe4nGm38dLS=2RyNQVAF227xsaYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	Git mailing list <git@vger.kernel.org>, avarab@gmail.com,
	vmiklos@frugalware.org, Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:53:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOtD1-0006Zv-86
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 20:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbaIBSxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 14:53:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64020 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754692AbaIBSxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 14:53:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4227F372B8;
	Tue,  2 Sep 2014 14:53:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mq3JBHrMtu0OEzyjwxZWc5RMsao=; b=URjuFe
	20m/rdPBzkDCyyVsF3qo2tjKlTiry3dF5vO3WXg6g1ahRr6bf/AoMNYnafGFDsOf
	Clgzmew/6uiWHkUu7epHBa8mZQfCLLw5KkLHC/JR/T9fjXWAASC+CrxSUjbe56ON
	XWbc1U5JrnGvws2FajxL3nOAlGzDvZqRq+oXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uGFHHtYV24x8j9N0afiTKgAGIEELKNWD
	7QBMlwMiSKzAk9GeABtg7h48pUaSaHqIzbw+7WipNcWOE/BKk8sfIiMm1hEtCOOo
	kcF/94UlHW0Vp72/EOYta41lQq6C37kg1oFyNROaX8PEO62iP1tBuLY6xJ2qFohW
	5XVJK7rz2Eo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37A5D372B7;
	Tue,  2 Sep 2014 14:53:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ADE94372B6;
	Tue,  2 Sep 2014 14:53:33 -0400 (EDT)
In-Reply-To: <CALKQrgdd588+-L2QB1LixQfe4nGm38dLS=2RyNQVAF227xsaYg@mail.gmail.com>
	(Johan Herland's message of "Sat, 30 Aug 2014 22:05:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 70572A6E-32D2-11E4-B6E2-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256336>

Johan Herland <johan@herland.net> writes:

> On Sat, Aug 30, 2014 at 9:56 PM, Alex Henrie <alexhenrie24@gmail.com> wrote:
>> Hi, I submitted this patch a week ago and got no reply, so I'm sending
>> it again and CC'ing the original authors this time...
>>
>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>
> Looks good to me.
>
> Acked-by: Johan Herland <johan@herland.net>

Looks good to me except for the log message part ;-).

Thanks.
