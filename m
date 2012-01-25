From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Rebase and incrementing version numbers
Date: Wed, 25 Jan 2012 12:18:56 +0100
Message-ID: <CAP8UFD080jii=86+EXkLC_Dmcs52j+ta=-i=6b1KedC=8WQ6MQ@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	<CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
	<1327000803.5947.59.camel@centaur.lab.cmartin.tk>
	<CAP8UFD0gd_-=Cc0vox-6Ts4-iBWcJG8LgmqXteXgp3qc-bX13w@mail.gmail.com>
	<1327488820.3052.15.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mike@nahas.com, git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Jan 25 12:19:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq0sX-0000Ft-MG
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 12:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab2AYLS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 06:18:57 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51557 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab2AYLS4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2012 06:18:56 -0500
Received: by pbaa10 with SMTP id a10so2939250pba.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 03:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZX7Lv5VuoNMFkXGOFeE91pBymq2oxTiDF6XVPrO10W4=;
        b=wh+GQJf5Cl9uDutPUDmivU18GlA7p74Vep+5LtGnFDerzixFjoGbsBz47qvqC3amMr
         ydQRIJZbQA+qR3e5aEM/d/Jup5vNan9SanvNoaK/REk/oyIUfZe+ntnaxSpQv1S3NMhE
         juWCNz+GB9Hi0pbdSzUoHZQ8rSA0YVW5l5i2Y=
Received: by 10.68.240.135 with SMTP id wa7mr11674067pbc.7.1327490336176; Wed,
 25 Jan 2012 03:18:56 -0800 (PST)
Received: by 10.142.196.10 with HTTP; Wed, 25 Jan 2012 03:18:56 -0800 (PST)
In-Reply-To: <1327488820.3052.15.camel@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189108>

On Wed, Jan 25, 2012 at 11:53 AM, Carlos Mart=EDn Nieto <cmn@elego.de> =
wrote:
> On Wed, 2012-01-25 at 11:32 +0100, Christian Couder wrote:
>>
>> By "merge" driver you mean a new merge startegy?
>
> No. By "merge driver" I mean a "merge driver".

Oops yeah, sorry, I should have searched.

Thanks,
Christian.
