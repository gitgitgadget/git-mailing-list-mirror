From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Thu, 12 Mar 2015 11:43:00 -0700
Message-ID: <xmqqegou2h1n.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
	<CACsJy8CHmdSRTfspKfSqtg7VXT7D6uxqr49KQQe8dhE5popakg@mail.gmail.com>
	<xmqqd24g6uf1.fsf@gitster.dls.corp.google.com>
	<CACsJy8D38Lx5zvpOGPvnYVNXh4EYbF+rLL8kwb9pwP7EqCqfxQ@mail.gmail.com>
	<xmqqbnjy4y0t.fsf@gitster.dls.corp.google.com>
	<20150312074511.GB12418@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:43:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW84b-0005k2-K0
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 19:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbbCLSnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 14:43:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751376AbbCLSnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 14:43:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C29F3F6B1;
	Thu, 12 Mar 2015 14:43:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jWbi3kDCpU5Ises2AavgM1w4sw0=; b=JBvf6Z
	zgnro0teci1kO0qW1XwLIHft8JH638IGWRLR3XvGvjpJAsaKT9kGVtYwY5euat5S
	mU+AgZOCbgnIOGNwwH1dn/4RIyAyjYEmRR7tRUVEz8nikZdzAKn9eiCapJB8iIfZ
	+OhOgW9eExgo8K983692khBOEXewBoPrLJh1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=leSof8Eqy61BSzKEasH0z5CoXhU4cIPY
	g5fF48W2i/0U5Cat/tvYsgNiPRutPz64eNIW6e0AwaELuMvVKiAXhXphItbJayFg
	EfTR3gq8ck0JUTdBhnijtZV8BCe59rLfrHKVl0n327EWBLdngsfzWOG8Cg+XvMOJ
	TNd6v9lMufk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 941113F6B0;
	Thu, 12 Mar 2015 14:43:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 098373F6AB;
	Thu, 12 Mar 2015 14:43:02 -0400 (EDT)
In-Reply-To: <20150312074511.GB12418@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Thu, 12 Mar 2015 08:45:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9CC673F6-C8E7-11E4-85F9-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265367>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Wed, Mar 11, 2015 at 09:53:22PM -0700, Junio C Hamano wrote:
>> I'd first suggest to employ "icase" to unify *-By and *-by.  Perhaps
>> we would want a recommended list somewhere in SubmittingPatches to
>> discourage people from getting too creative?
>
> There's already such list in SubmittingPatches, so there's already quite
> a few to choose from:
>
> Also notice that a real name is used in the Signed-off-by: line. Please
> don't hide your real name.
>
> If you like, you can put extra tags at the end:
>
> 1. "Reported-by:" is used to credit someone who found the bug that
> 	the patch attempts to fix.
> 2. "Acked-by:" says that the person who is more familiar with the
> 	area the patch attempts to modify liked the patch.
> 3. "Reviewed-by:", unlike the other tags, can only be offered by
> 	the reviewer and means that she is completely satisfied that the
> 	patch is ready for application.  It is usually offered only after
> 	a detailed review.
> 4. "Tested-by:" is used to indicate that the person
> 	applied the patch and found it to have the desired effect.
>
> You can also create your own tag or use one that's in common usage such as
> "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".

Hmph, the first step might be to drop that last sentence, I guess,
if we consider this a "mess" and if we want to clean it up.
