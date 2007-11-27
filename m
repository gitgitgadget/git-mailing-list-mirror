From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 09:52:18 +0100
Message-ID: <200711270952.18541.jnareb@gmail.com>
References: <200711270622.lAR6MFXR010010@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: =?utf-8?b?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:52:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwwBR-0002w2-KX
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 09:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbXK0Iw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 03:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbXK0Iw1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 03:52:27 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:11114 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbXK0Iw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 03:52:26 -0500
Received: by wr-out-0506.google.com with SMTP id c49so787709wra
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 00:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=l/emXQsST8gDDikxR8OpwdOuv0xxwZJmR102mHfWXQ8=;
        b=sGvUfqrXZfUoL+C7kdtyRx951dGNDYlDTP+of2ofvWsYPRSpGS6ub/qh1fNBOUhxnRwAe8PEQLKxnWTO+IHh0j2dShhRlard3qkVcbR9zp/WjoJCkKujrrM+SkEG1xNo3Tvylno+vdNHB89jx5D25WEIKPhg3Q6Km4G2bgr8fRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jj5p3uq5ZfSW8mIGLM3cFSfVlymzMLk+1i+YiuAhMvEniMH2UYiotdKkrbxwdjpY6sEO5uRQ4w3cBnieT/A6SZ24jZS2kqHm7aWw3bOBNV8UOzos8QmGzqyJc2YduHamnGSqMvVJQuBvtvBUtRHzE+/q6hArRa2TYAdJNpc0c2s=
Received: by 10.86.81.8 with SMTP id e8mr2054965fgb.1196153544370;
        Tue, 27 Nov 2007 00:52:24 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.183])
        by mx.google.com with ESMTPS id l19sm3349761fgb.2007.11.27.00.52.21
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 00:52:22 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200711270622.lAR6MFXR010010@mi0.bluebottle.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66175>

On Tue, 27 Nov 2007, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=
=AA=E3=81=93 (Nanako Shiraishi) napisa=C5=82:
> Quoting Andreas Ericsson <ae@op5.se>:
>=20
>> "git pull --rebase" already has an implementation. Dscho cooked one =
up
>> which I've been using since then. It works nicely.
>=20
> What is the reason that the option was not added to the official git?
> Was it coded poorly, buggy or were there some other issues?=20

There was no main (feature) git release since?

--=20
Jakub Narebski
Poland
