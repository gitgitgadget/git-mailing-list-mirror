From: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Mon, 06 May 2013 18:29:17 +0200
Organization: Universitas Osloensis
Message-ID: <15ty5bsax7m.fsf@tux.uio.no>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
	<vpq1u9kunba.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 06 18:29:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZOI0-0004rm-GD
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 18:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239Ab3EFQ3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 12:29:20 -0400
Received: from mail-out5.uio.no ([129.240.10.17]:48620 "EHLO mail-out5.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098Ab3EFQ3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 12:29:19 -0400
Received: from mail-mx6.uio.no ([129.240.10.40])
	by mail-out5.uio.no with esmtp (Exim 4.80.1)
	(envelope-from <t.h.amundsen@usit.uio.no>)
	id 1UZOHt-0004oG-V0; Mon, 06 May 2013 18:29:17 +0200
Received: from tux.uio.no ([129.240.6.13])
	by mail-mx6.uio.no with esmtp  (Exim 4.80.1)
	(envelope-from <t.h.amundsen@usit.uio.no>)
	id 1UZOHt-0008Fh-Gs; Mon, 06 May 2013 18:29:17 +0200
Received: by tux.uio.no (Postfix, from userid 45150)
	id 6A3554B5; Mon,  6 May 2013 18:29:17 +0200 (CEST)
In-Reply-To: <vpq1u9kunba.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Mon, 06 May 2013 17:42:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-UiO-Ratelimit-Test: rcpts/h 8 msgs/h 3 sum rcpts/h 10 sum msgs/h 4 total rcpts 5519 max rcpts/h 30 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.7, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-0.653,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 3255F1B4C8F8E7EAB84405B7FF1CBA7FA7CE8FFF
X-UiO-SPAM-Test: remote_host: 129.240.6.13 spam_score: -56 maxlevel 80 minaction 1 bait 0 mail/h: 3 total 1451 max/h 9 blacklist 0 greylist 1 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223469>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> The included patch attempts to improve post-receive-email. It's a
>>
>> Please don't ;-)
>
> More precisely: you should have a look at git-multimail (in directory
> contrib/, in branch for now pu/, or from
> https://github.com/mhagger/git-multimail) before spending time on
> post-receive-email.

Thanks for the tip, I'll check it out. I used post-receive-email out of
convenience, as it was already there.

Regards,
-- 
Trond H. Amundsen <t.h.amundsen@usit.uio.no>
Center for Information Technology Services, University of Oslo
