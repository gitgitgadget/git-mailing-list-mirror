From: Maxin john <maxin@maxinbjohn.info>
Subject: Re: [PATCH] Remove "bashism" from contrib/thunderbird-patch-inline/appp.sh
Date: Wed, 30 Mar 2011 21:51:25 +0300
Message-ID: <AANLkTinrfswqETPVjDEuKon8ntcgUpkizxit84b4imno@mail.gmail.com>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
	<4D9103D3.5010403@zoho.com>
	<7vei5qtnc5.fsf@alter.siamese.dyndns.org>
	<4D9261AE.5070103@zoho.com>
	<AANLkTim+0gxGKZT=vfmX7v0QZrApjRwAzW3PiLePL-iQ@mail.gmail.com>
	<7vmxkco5jg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>,
	Victor Engmark <victor.engmark@terreactive.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 20:51:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50UV-0001em-AT
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 20:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320Ab1C3Sv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 14:51:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61611 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab1C3Sv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 14:51:26 -0400
Received: by yxs7 with SMTP id 7so651335yxs.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 11:51:25 -0700 (PDT)
Received: by 10.150.239.7 with SMTP id m7mr1951261ybh.55.1301511085141; Wed,
 30 Mar 2011 11:51:25 -0700 (PDT)
Received: by 10.150.139.2 with HTTP; Wed, 30 Mar 2011 11:51:25 -0700 (PDT)
X-Originating-IP: [91.154.177.92]
In-Reply-To: <7vmxkco5jg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170403>

Hi,

>
> I'd just replace /bin/bash with /bin/sh without any other fuss, perhaps
> except for the typofix in the comment, and be done with the topic.
>

I agree with this. The changes were mostly cosmetic and has nothing to
do with the functionality of the script.

>
> Thanks, I'll apply the early hunks from you.
>

Thank you very much.

Best Regards,
Maxin B. John
