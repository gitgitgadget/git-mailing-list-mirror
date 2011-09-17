From: =?UTF-8?B?RnLDqWTDqXJpYyBIZWl0em1hbm4=?= 
	<frederic.heitzmann@gmail.com>
Subject: Re: [PATCH v3] git svn dcommit: new option --interactive.
Date: Sat, 17 Sep 2011 15:11:03 +0200
Message-ID: <4E749C67.9060308@gmail.com>
References: <1316206921-29311-1-git-send-email-frederic.heitzmann@gmail.com> <1316261904.6897.9.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <carlos@cmartin.tk>
X-From: git-owner@vger.kernel.org Sat Sep 17 15:11:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4ufx-00083x-Pd
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 15:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab1IQNLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Sep 2011 09:11:13 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:54125 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab1IQNLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 09:11:13 -0400
Received: by wwn22 with SMTP id 22so1780726wwn.1
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2bqeRugg+UJUQS2/Z7AJgAAtcu+uihxsRQ4wIEdq0A8=;
        b=CnYIElzntGaeLfm3ttUVWX9WONXrecPF1wqWvzD3TbswN5IlqgCOyRRfRr9dJAIFFU
         kMNzcNO/lAmmB18VSvEweHFqyQsTt4eVY7cthOtWhH2790hTX74jniv0d8NabeHtVK7z
         dZG8fWTBNJH0irrJo7+vIRZePP8SIbrnXCX8s=
Received: by 10.227.10.139 with SMTP id p11mr580598wbp.61.1316265071738;
        Sat, 17 Sep 2011 06:11:11 -0700 (PDT)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net. [88.179.84.80])
        by mx.google.com with ESMTPS id fr18sm16979840wbb.9.2011.09.17.06.11.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 06:11:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
In-Reply-To: <1316261904.6897.9.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181581>


Le 17/09/2011 14:18, Carlos Mart=C3=ADn Nieto a =C3=A9crit :
> [removed Junio from CC as he doesn't want to know about this patch at
> this stage]
>
> On Fri, 2011-09-16 at 23:02 +0200, Fr=C3=A9d=C3=A9ric Heitzmann wrote=
:
>> Allow the user to check the patch set before it is commited to SNV. =
It is
> Typo: SNV ->  SVN
>
> My perl-foo isn't strong enough to properly review the rest.
>
>     cmn
Thanks.

--
=46red
