From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 14:18:04 +0000
Message-ID: <CAPabhsKV6GM92J5vib9d79DW3LDXeS40s+-M5OHBKmfXGezaOQ@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<20121031102712.GB30879@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
	<CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
	<20121031185903.GA1480@elie.Belkin>
	<CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
	<alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server.info>
	<bec4d263-b458-4636-9fa6-1c1202416810@email.android.com>
	<CAMP44s2G2MGuPH-UXfoKNOpx0cuSE87Uz=6B-7H1MzJHf6VMjA@mail.gmail.com>
	<50927D29.3020703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:18:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTvbB-0005Op-1C
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 15:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761520Ab2KAOSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2012 10:18:08 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:41799 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011Ab2KAOSH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2012 10:18:07 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1871709lag.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OVIoGCqAzeUZ6vGKet9jyKdNDSJCgEo4YGxN0Gjpa80=;
        b=rWTu2VD0VmypSj/RUgQlLjKzAR28yow2au3HRKNd2eW3u9iEeOeZ6FuqmMLc0Srn/d
         ySTrka4I5Y34fJO/o6CcZiso0GVSvhc+GxKeV9MpuXYh4x9u27yFKlM/o+0TBdAwdiBy
         /H+nl5fKGhAxV5Dzfh2pO5rLrBu/oB2JlbIUPtVFYluum71KrmmvGBysPzHf01YFlSPS
         5EKh8iyUjQmFRH0CPUmeazckISbJBLd0lZCpMznByCWHbra46ucEGBBYvpZcnYCZ0aWx
         zOD2v0U6RKDpYsYp/c1jB+Twl+2FooshiG2sA0H+CM8sd1bgYKLbh+rF+RwYwQeJ/2vw
         0Gww==
Received: by 10.152.106.110 with SMTP id gt14mr36628844lab.1.1351779485027;
 Thu, 01 Nov 2012 07:18:05 -0700 (PDT)
Received: by 10.114.62.201 with HTTP; Thu, 1 Nov 2012 07:18:04 -0700 (PDT)
In-Reply-To: <50927D29.3020703@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208875>

On Thu, Nov 1, 2012 at 1:46 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Also, and I'm sure you didn't know that, "Jedem das Seine" (to each h=
is own)
> was the slogan of the Buchenwald concentration camp.  For that reason=
 some
> (including me) hear the unspoken cynical half-sentence "and some peop=
le just
> have to be sent to the gas chamber" when someone uses this proverb.

Godwin's Law. That went fast, just one day :)
