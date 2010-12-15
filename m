From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: TopGit release?
Date: Wed, 15 Dec 2010 17:48:39 +0100
Message-ID: <AANLkTinfDgvmodzrW7eMW-iizxpvb+gvBgSsH9B3LOdu@mail.gmail.com>
References: <87ei9k42v5.fsf@write-only.cryp.to>
	<20101215080148.GA28971@pengutronix.de>
	<AANLkTi=E2H8n8jZPQ0Rz5gxaQTeLtJXeCFFZv08dip0E@mail.gmail.com>
	<20101215153226.GF28971@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Simons <simons@cryp.to>, git@vger.kernel.org,
	martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Dec 15 17:49:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSuXD-0004aa-SO
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 17:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab0LOQsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 11:48:45 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:64714 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0LOQsm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 11:48:42 -0500
Received: by gxk19 with SMTP id 19so1421178gxk.11
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hm91sPYoIrEmKFLBN0PePnjAIcGPhUB5RONGm64gF/4=;
        b=G9Hz1G+DqxJVJLybuZLZ67CxKs60XsxaQTQd3ovVC3evX9+Xwd5IaAiKs+4XCYbQ/E
         wj+rjiXCH/heP17IhbLxgPGwB2gicU30/voWO3oNg6EbntExTJwhiHZUfb9FiVEXk+7J
         rkZLSEjZUsWVo5erueKG+Cq+qj8Ct0HYOkg8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Skldh7b8js6CvIMJDSQ6StRyFQAB/VB0KqHi0Fwris6GumjhO6P0hJTPjLO4RkGLC5
         f31c4pNJiAv9HjkDyo+SyH3UewLsRb/881hDzo0gKkmNLpKPFz1IRIYtRiP9WIdT/nJM
         76yn/lxAzurQh+atrbrlWsJl0FWRtYL5keBAQ=
Received: by 10.42.177.195 with SMTP id bj3mr6187450icb.90.1292431719512; Wed,
 15 Dec 2010 08:48:39 -0800 (PST)
Received: by 10.42.167.74 with HTTP; Wed, 15 Dec 2010 08:48:39 -0800 (PST)
In-Reply-To: <20101215153226.GF28971@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163787>

Hi,

2010/12/15 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Bert,
>
> On Wed, Dec 15, 2010 at 03:54:28PM +0100, Bert Wesarg wrote:
>> 2010/12/15 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
>> > [1] http://thread.gmane.org/gmane.comp.version-control.git/159433
>> > =C2=A0 =C2=A0hint to Bert: this series doesn't apply to master
>>
>> I know, you applied a patch, which was rendered obsolete with this
>> patch series. you commited on Nov 02, and I send the series Oct 20.
> If you tell me the commit you based your series on I can use the same
> and merge the result into master.

8b0f1f9d215d767488542a7853320d1789838d92

But I just refreshed my repo.or.cz fork (topgit/bertw), where I pushed
a rebased series (I've done this some time ago already)

git://repo.or.cz/topgit/bertw.git index-wt

Bert
>
> Best regards
> Uwe
