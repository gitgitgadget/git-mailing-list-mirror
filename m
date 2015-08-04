From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 0/10] Port branch.c to ref-filter.
Date: Tue, 4 Aug 2015 18:31:53 +0530
Message-ID: <CAOLa=ZSR=7mvOG+RPSJ_xxr3k644WOiqirTrNMo-=jcXbtM3yw@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 15:02:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbrr-0003ub-K3
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbbHDNCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:02:39 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35994 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964866AbbHDNCX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:02:23 -0400
Received: by obnw1 with SMTP id w1so6253130obn.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TBLqUap3qQ/DtZvPRefrRCn4hhr57EBi4wJOXd3Axrw=;
        b=Ias9YNFAwgY2lbAs2IhMcY/CDuDmq9OOaoaWxPG6gIl4Dzfsb36QGAlyoJocFv3q1b
         NFqVefOUQ0NBws8X7lxV6MC+KYFDF+7qulFbQzIst5AeRps0Zpa3mX/qvQzfvuCxKGjB
         sIS6uV3Cb0B5VnnGJwrIsA2MGdcVFG6sBKMM7WNFH+6nFBwGDDrKuJWPAB8VKTyvtR9V
         3KovYr+ynZeVywtHTKDP6HZmkfAqWy166mv5trmU0aMaPLeLqG1t6ssURnPGiCwTFM+L
         Q5R0DbXW2wIkyr4V8JwjjmfXNSWVOSKRFPz/moNAANf5c/vUmX1oDfGzNOv+9Ztg6IbA
         fTTg==
X-Received: by 10.60.41.138 with SMTP id f10mr2975243oel.84.1438693342798;
 Tue, 04 Aug 2015 06:02:22 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 4 Aug 2015 06:01:53 -0700 (PDT)
In-Reply-To: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275274>

There are nine patches in the series. Have put "0/10" by mistake.

-- 
Regards,
Karthik Nayak
