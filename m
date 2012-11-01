From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 01 Nov 2012 10:32:17 +0900
Message-ID: <bec4d263-b458-4636-9fa6-1c1202416810@email.android.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com> <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <20121031102712.GB30879@sigill.intra.peff.net> <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info> <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com> <20121031185903.GA1480@elie.Belkin> <CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com> <alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server
 .info>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 02:32:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTjeA-0002sr-CF
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 02:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761333Ab2KABc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 21:32:26 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:58261 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002Ab2KABcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 21:32:25 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so909601dak.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=v/g6L9v59uFx7xM96E3NUjvKS/M8L3EVdnC7aJqhNu8=;
        b=CFjHeq9m3gQwFA7WVk1EvkmMOzbREUj5eP4mIIPLSygEzQOp80M6j7mvPy/xz1MLn2
         aFfp+fvEFRvoey3Js17qkGxXoEST8M3VFhD5TCGHPhCvbK37UUx6kpvppftWltMNuSi3
         3Hn3Y7lU+/1PITiA7yK33EhKgx3zoRXl2jzVZN+BhydgLLn/Bm13FpmCGq2sSJfNJBbn
         zZdPeKlyvK0VyF53bnOjbqReaj2+EkDKTwv6Oc9GVYZv1OCznlhSKehvJYbzKISoG9wJ
         EiQ99szwhHBeh2GE2bqx+h1cPcbmqDLKHZ/5TILNn11uRf4+y/ia1CzM/g7ofuNRee03
         Qx8w==
Received: by 10.68.224.69 with SMTP id ra5mr117405300pbc.114.1351733544945;
        Wed, 31 Oct 2012 18:32:24 -0700 (PDT)
Received: from [192.168.0.3] (112.136.53.59.er.eaccess.ne.jp. [112.136.53.59])
        by mx.google.com with ESMTPS id su7sm3126335pbc.72.2012.10.31.18.32.22
        (version=SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 18:32:24 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208857>



Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

>On Wed, 31 Oct 2012, Felipe Contreras wrote:
>
>> It doesn't get any more obvious than that. But to each his own.
>
>In my opinion, Jonathan does not deserve any of such condescending
>words.
>But maybe the Git maintainers are okay with such a tone on this list?

Agreed, and no.

We've been hoping we can do without a rigid code of conduct written down to maintain cordial community focused on technical merits, and instead relied on people's common sense, but sense may not be so common, unfortunately, so we may have to have one.
