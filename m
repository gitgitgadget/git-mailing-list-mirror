X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git crash when cg-fetch:ing dash
Date: Thu, 23 Nov 2006 10:34:52 +0100
Message-ID: <45656B3C.4090601@lsrfire.ath.cx>
References: <200611230247.kAN2lbLU006457@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 09:35:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <200611230247.kAN2lbLU006457@laptop13.inf.utfsm.cl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32127>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnAz9-0005Nt-4d for gcvg-git@gmane.org; Thu, 23 Nov
 2006 10:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933386AbWKWJfG convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 04:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933539AbWKWJfG
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 04:35:06 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:16258 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S933386AbWKWJfE (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23
 Nov 2006 04:35:04 -0500
Received: from [10.0.1.4] (p508E51A7.dip.t-dialin.net [80.142.81.167]) by
 neapel230.server4you.de (Postfix) with ESMTP id B9F6126012; Thu, 23 Nov 2006
 10:35:03 +0100 (CET)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

Horst H. von Brand schrieb:
> I did:
>=20
>   git clone http://gondor.apana.org.au/~herbert/dash/dash.git
>=20
> and got:
>=20
>   error: Unable to start request
>   error: Could not interpret heads/master as something to pull

It works for me with both the version of git that came with Ubuntu 6.10
(1.4.1) and a self-compiled git 1.4.4.g5942. :-?

