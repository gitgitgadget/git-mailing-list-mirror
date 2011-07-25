From: Graeme Geldenhuys <graemeg.lists@gmail.com>
Subject: Re: git-pull doesn't update my refs for remotes/origin/master
Date: Mon, 25 Jul 2011 10:48:57 +0200
Message-ID: <4E2D2DF9.8000509@gmail.com>
References: <4E2D223E.8090505@gmail.com> <4E2D2ADE.40407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 25 10:49:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlGqf-0000tH-Fa
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 10:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab1GYItG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 04:49:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63521 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab1GYItE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 04:49:04 -0400
Received: by wwe5 with SMTP id 5so3851108wwe.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yOUFvtRs4UGfdU8CQpEM6932PkaK6Kgg+DxOyILQ7uo=;
        b=b/jD5eevKexXM8sAJeW54GUOezzC2QtQnM2yte0EYM/KTyGf76q2jnDKIED5RnWSK6
         KYPI0YgFzLKPxuH9mCN/HYSANr1PomFcsSmTZQy0TFPau/dJrdhm7e0GBwPHNiKEAY18
         gCouBgzIQWT8Nf5EW0MKDqghGoCp826vEeMvo=
Received: by 10.227.181.9 with SMTP id bw9mr847789wbb.38.1311583741453;
        Mon, 25 Jul 2011 01:49:01 -0700 (PDT)
Received: from [192.168.0.53] (41-133-134-247.dsl.mweb.co.za [41.133.134.247])
        by mx.google.com with ESMTPS id fe4sm4127682wbb.45.2011.07.25.01.48.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 01:49:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <4E2D2ADE.40407@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177787>

On 07/25/2011 10:35 AM, Michael J Gruber wrote:
> 
> Here's my quote from git-pull's man page:

Clearly I need to read the help with more attention. :)


> I.e., just do "git pull origin".

OK, so I was trying to be too helpful. Git is clever enough, so using a
simplified command line is better in this case. Many thanks for the
quick reply.


Regards,
  - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://fpgui.sourceforge.net/
