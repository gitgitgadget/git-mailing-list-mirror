From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v5 6/7] Remove dead code which contains bad gettext block
Date: Wed, 25 Jul 2012 21:31:29 +0800
Message-ID: <CANYiYbF9KsBeRsVV1RCD9k5KQFnf-9ubc-YLHLg+LjMSoPLVoA@mail.gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
	<b22ea7d7306745555bfd39bf4ff51f485a005a02.1343205009.git.worldhello.net@gmail.com>
	<20120725113009.GA4732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 15:31:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su1ge-0006K7-SG
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 15:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678Ab2GYNbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 09:31:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38873 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343Ab2GYNba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 09:31:30 -0400
Received: by yenl2 with SMTP id l2so678556yen.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0CbCm5smKJ720wfxbLHE7pfaMnjWBASkDf+sSofzToM=;
        b=yXy6OnXoYIKA2k/gcIVZFO8d0HrCN5mp4xxoziaGLWRoXcvkQ7eXWnGVX0pV5nEyck
         Ib/lt2LMxkd2k/elclYsSTjF+yxlBn1Nzm1uQWmeM+l9WeJpE6pNzaJyR0RPApxopcpg
         2B1OpWXE5HFgJxkQkwqA72uKaqK7YT47bIw0AtuaDxUmdETHLZ91WuBMtA75Ml7prF/g
         7JuR8xJaW48CcGtex+AEx2AioP0bdTvHuV/RMEdzrrsIc4o4te45S2kGUO8IlCXOfPx5
         OHSqR4LqyHfPGQPd2M15armTA+CGOAwGuqeuSjCSvRpktITNrqIKFjBZ35cVYaTP3AJw
         ErpA==
Received: by 10.42.146.6 with SMTP id h6mr24537758icv.53.1343223089284; Wed,
 25 Jul 2012 06:31:29 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Wed, 25 Jul 2012 06:31:29 -0700 (PDT)
In-Reply-To: <20120725113009.GA4732@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202149>

2012/7/25 Jonathan Nieder <jrnieder@gmail.com>:
> Jiang Xin wrote:
> s/Junathan/Jonathan/, please, unless you are trying to say that both
> Junio and I pointed it out at the same time.

Sorry. Correct it in next series of patches.
I don't know how this happens until now.

-- 
Jiang Xin
