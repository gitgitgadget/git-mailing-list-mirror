From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: Regarding GSoC 2016
Date: Thu, 24 Mar 2016 23:30:31 +0530
Message-ID: <CA+DCAeTh9CWz7pDaa8T4G2KVsqmOpPbO+E4en3qrmRs8sjk4Rg@mail.gmail.com>
References: <loom.20160324T184240-765@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Saurabh Jain <saurabhsuniljain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 19:01:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9Yr-0005or-1v
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbcCXSAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 14:00:36 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36176 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbcCXSAd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 14:00:33 -0400
Received: by mail-qg0-f43.google.com with SMTP id u110so44598161qge.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=+py5EIihe0+vihKjjN/DwLUjvbM2HNqTfmUbo+e5sk8=;
        b=P2gUb/eRF7VkSrNv0Hrw6eZOEDfTo17T0e7HKIBFYAbojU3N3OHa690Et2hQPYvtXo
         MLwgcpL5AfkVV3NP/iSeqtvQj6V+qI3Oabr7BWD0c3G43faERxF+AGrqaMJhfkULnNav
         ISNR9DrjvIMyCTZnr0d+PYoJ2tOY+P9YCqoJIVKNM7GmoFuOGRGb/Rn/MdsYC1Exnt6T
         FHwpmCV8OFwsDWthhVDJKKGyS/t5bOR8K8lZI7KZZ/fvc+lh1OqV34+K5MadLCWFJ+gI
         MQ28lM7ghfVHXfjNFGz9V46ghK9pHBgTHa6KUcXs6utsjQQzEC9RtF0z6OopQAtHPQj4
         TDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=+py5EIihe0+vihKjjN/DwLUjvbM2HNqTfmUbo+e5sk8=;
        b=AHGcT6dogCl32ceczKwuPjasN9B1qBgcegTSgagUJ2jtFUlVlRvvIRT95oygADKaDl
         Rm6n2Tsgu52UyCKhrb1My5+Afphbj42WnmeU4BtBqMA2DfQdmqfPpRgPJzG5bcpnSp5P
         ixroKApVXe7nbcG4AlhnpFVIfXHS9tjKopdtEM6N6Yz4kUVajyPk3dSuBk5WmOm45hg4
         vxJjiDSTxJtx8+AUqdktigfRjmJzXsW4M7ZOgTTa88Y9CTm4E9rutdSusnkA6wmjl8Ud
         iM1qgxD1MIrlj4biyzoWhqULkroTztgpdpwskyH/+euuRDyuGHpcQz6cmSyDnDk0VQWW
         GwkQ==
X-Gm-Message-State: AD7BkJKRqhbN/Y9NNV/Wwaa4VpuB5FvBZVHgdzkdrGuPYRiFlVVynBDlVhe1nophmQW+X+VYv1t1m871yieeDA==
X-Received: by 10.140.41.164 with SMTP id z33mr12463668qgz.78.1458842431903;
 Thu, 24 Mar 2016 11:00:31 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Thu, 24 Mar 2016 11:00:31 -0700 (PDT)
In-Reply-To: <loom.20160324T184240-765@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289775>

On Thu, Mar 24, 2016 at 11:13 PM, Saurabh Jain
<saurabhsuniljain@gmail.com> wrote:
> The proposal can be accessed here.
> <https://docs.google.com/document/d/1gywGgdpDclnptvX-
> 5mWF_cqoZS6IUvGr6CVu5SmkbZk/edit?usp=3Dsharing>

It's broken I guess.

Also Cc  Carlos Mart=C3=ADn Nieto <cmn@dwim.me>. He is one of
the possible mentor on this one.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
