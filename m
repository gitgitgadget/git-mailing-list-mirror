From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Support] Branch pointer does not move
Date: Mon, 14 Mar 2011 16:24:52 +0100
Message-ID: <AANLkTinDurbM0nd_WppA-KaVYdxZzT6593hneC4AK+91@mail.gmail.com>
References: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box> <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com>
 <op.vsb95dilbl4hj1@metalltrottel.fritz.box> <AANLkTimW+01wriSjvEVEyQ8SE5RPxhGv_o2Rus9kw6ZQ@mail.gmail.com>
 <op.vscae5mbbl4hj1@metalltrottel.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Franz Liedke <franz@develophp.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:25:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz9eT-0002z5-Ra
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 16:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab1CNPZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 11:25:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57937 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531Ab1CNPZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 11:25:41 -0400
Received: by gyf1 with SMTP id 1so919857gyf.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3MfR7sZtX1VGYHp4c8Zx1qvpiD4dkVq830Ywx1ji15E=;
        b=AA7izoTf8wevStLjCdBplbmnCOdO0M8cUMOXVrd7P69KZKEOtyQ2BLpvRKvqsFl8dl
         Qb2hbvHWOxxN/UGB6wkCzS+7rY+XnTpskxdP3D93nEfzkUhCzSBquzuouM3J01PmuiPf
         ARBcWkWgDqGpdjTMSWdYj1nmR0erFlxBLrMtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rNB1uTnL+zMzSeB1kiJJVm4BcAoeowbAGSefOW5AErm+rFM64cw0jW1Ij8/BlY15yj
         QPprXRrze/RmQcx2JUauEbKtDUOB0MZohjixjU4tBlfyItX55d0fUJsd9mpsbaxod3/4
         TFt8U8Io8TwLd0+c5Tsm3vKpSQeLee7nfsJ3k=
Received: by 10.150.148.7 with SMTP id v7mr1156119ybd.49.1300116340377; Mon,
 14 Mar 2011 08:25:40 -0700 (PDT)
Received: by 10.151.11.12 with HTTP; Mon, 14 Mar 2011 08:24:52 -0700 (PDT)
In-Reply-To: <op.vscae5mbbl4hj1@metalltrottel.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169073>

Heya,

On Mon, Mar 14, 2011 at 16:24, Franz Liedke <franz@develophp.org> wrote:
> Oops, sorry I didn't make that clear. The branch pointer is still displayed
> next to the old commit in SmartGit, the GUI I normally use.

Have you tried turning it on and off again [0]? As in, did you close
and start SmartGit and/or refresh it (if it has such an option)?
Perhaps it keeps some sort of internal state.

[0] http://www.youtube.com/watch?v=p85xwZ_OLX0

-- 
Cheers,

Sverre Rabbelier
