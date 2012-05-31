From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCHv4 1/3] wt-status.*: better advices for git status added
Date: Thu, 31 May 2012 16:34:29 +1000
Message-ID: <CAH5451kTS+LhVoSz_jiz4UTK_AwocMzn9HctOLyAUDN9j492Aw@mail.gmail.com>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <vpqipfcsw1x.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 31 08:34:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZyyE-00042T-Ss
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 08:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab2EaGev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 02:34:51 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62237 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab2EaGeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 02:34:50 -0400
Received: by wgbdr13 with SMTP id dr13so558524wgb.1
        for <git@vger.kernel.org>; Wed, 30 May 2012 23:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H2XADxTWRwbePItGZ6T1cprlP7eGGBnTf9y5ra3AQKY=;
        b=07fwQtU97Xp3yLk7sv3Xd4eBkQBEUsf2o9MJyutMU+SekgT9Oztjk070/2Kq/DmBeg
         1Y9qcoagWQaSPBMouqvpWHxiGzw3DLGsT2oc6ifbRarwGKtH1FF9Wp4eJq4e9OnGsZX/
         r8dAILeWS6My8ZXE2EbtkI/waFZEr/pGaDMdTbGemWM8LyxedAiMoKgXEVslqOx1Hah2
         vOHU8LaW08LUe9lFKxdD4aJRwNF+hs1jS0NvlusqSGktqU5ObmZ0mPguqx4n8WAQGjOZ
         9tOyIPU/kvPCbx/Kh56OVUGKGlqi/QPDJC+j1mlacPp/4PhWa5yD7d0wCZrv+/Eoo9ZY
         8lkA==
Received: by 10.216.228.150 with SMTP id f22mr11326016weq.192.1338446089317;
 Wed, 30 May 2012 23:34:49 -0700 (PDT)
Received: by 10.223.86.80 with HTTP; Wed, 30 May 2012 23:34:29 -0700 (PDT)
In-Reply-To: <vpqipfcsw1x.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198863>

On 31 May 2012 16:29, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:
>
>> The new messages are not shown when using options such as
>> -s or --porcelain.The messages about the current
>
> space between . and The (normally, 2 spaces in english).

It is not common practice to use 2 spaces after a period any more,
especially on the web. A good summary of information around using 1 or
2 spaces after a period can be found at [1]

Regards,

Andrew Ardill

[1] http://www.webword.com/reports/period.html
