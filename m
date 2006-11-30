X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 22:58:09 +0100
Message-ID: <200611302258.09523.jnareb@gmail.com>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <f2b55d220611301341n45c45506rca312dfa8ee6f795@mail.gmail.com> <8764cwtxhm.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 30 Nov 2006 21:56:40 +0000 (UTC)
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EeuscPAKfcNmimvqPPibvwiD1pNS4yA+iXHU7u1zrGfgzQC34t3vd+eWfDGoblUEIhjUyKfcAJgODHVN72gLOlVoriBfhk5ilqaq8NZQ5BuEqY+s6Alblo73MNzIMaJc4G/5brOIPfXZfcea3f9wYq2PiSeTizzO384xGyGYBDE=
User-Agent: KMail/1.9.3
In-Reply-To: <8764cwtxhm.wl%cworth@cworth.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32808>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpttG-0006S5-Sw for gcvg-git@gmane.org; Thu, 30 Nov
 2006 22:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967940AbWK3V4U convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006 16:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967942AbWK3V4U
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 16:56:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:12706 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S967940AbWK3V4T
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 16:56:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2250818uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 13:56:18 -0800 (PST)
Received: by 10.66.239.18 with SMTP id m18mr6051718ugh.1164923777482; Thu, 30
 Nov 2006 13:56:17 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id e1sm24433679ugf.2006.11.30.13.56.17; Thu, 30 Nov
 2006 13:56:17 -0800 (PST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Dnia czwartek 30. listopada 2006 22:50, Carl Worth napisa=B3:
> On Thu, 30 Nov 2006 13:41:37 -0800, "Michael K. Edwards" wrote:
>>
>> git mark
>=20
> I actually thought of that. But compared to "refresh" it sounds more
> like something that suggests marking a file path rather than copying
> contents, so our dark lord might not approve of the wrong ideas it
> might allow to persist in brain-damaged heads.
>=20
> It is nice and short, which is a bonus though.

What about "git update"? "git add" would also work, I think.
--=20
Jakub Narebski
