From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: fix alphabetic ordered list for
 git-rebase man page
Date: Mon, 26 Mar 2012 10:32:31 -0700
Message-ID: <7vwr67p8sw.fsf@alter.siamese.dyndns.org>
References: <4F6C5F1B.6010603@seap.minhap.es>
 <7vd383t8vp.fsf@alter.siamese.dyndns.org> <4F7059B7.8080406@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:32:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCDmb-00052N-88
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091Ab2CZRcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:32:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933048Ab2CZRce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:32:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E83BA6C7E;
	Mon, 26 Mar 2012 13:32:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KQk77InzkNc+TiJLQYBauezUlsg=; b=ToWm/o
	ewiUo/d7rj2NqqTJvmVxRmYQo3H4+4dJ2htLHzKJ4vYI50Ixtlt3d9aCv7FlWY3j
	mh18d8oOudTeON0XkdmKnnw2jEYfnvWyp3WrwJ+IR7Hr6xHhOdTou/9d6HJMIRxs
	2SyQBzE60kZOjEDy9Y+lJy/d9TPatDpEebXoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SoeqmtkBk8FtPaTxdfZyS42DElUSPHbk
	7pjKVE1xB6gidcmogkvpYIJyJo1lO4efVQG+bCmza7RiiemtGulQIYK4zyJAv3XW
	6ZaeI4DwbWCXTUtw0U9YWmI6qZAMoA126XXby89ZQYx0xEm7DhXCrDlxwlGHqS2J
	JL4mkfEzHUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD3486C7D;
	Mon, 26 Mar 2012 13:32:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EBD26C7B; Mon, 26 Mar 2012
 13:32:33 -0400 (EDT)
In-Reply-To: <4F7059B7.8080406@op5.se> (Andreas Ericsson's message of "Mon,
 26 Mar 2012 13:57:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABACF944-7769-11E1-99DB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193936>

Andreas Ericsson <ae@op5.se> writes:

> On 03/23/2012 08:28 PM, Junio C Hamano wrote:
>> Thanks; sign-off?
> ...
> Just thought I'd throw that out there in case you, like I did, run into
> useful patches you dare not use because the original author gets hard
> to contact all of a sudden.

Thanks, but after seeing another series that is not as trivial as this one
from the same author, I was hoping that Nelson will become a part of our
regular contributor base ;-)

And obviously it will be less work on me in the longer term if I train the
regular contributors to do S-o-b themselves earlier in the process.
