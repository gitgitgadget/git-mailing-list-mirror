X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: git crash when cg-fetch:ing dash
Date: Thu, 23 Nov 2006 12:54:57 -0300
Message-ID: <200611231554.kANFsv9h005228@laptop13.inf.utfsm.cl>
References: <rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 15:55:44 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
In-Reply-To: Message from =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx> 
   of "Thu, 23 Nov 2006 10:34:52 BST." <45656B3C.4090601@lsrfire.ath.cx> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 23 Nov 2006 12:54:57 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32144>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnGuv-0004ZJ-1A for gcvg-git@gmane.org; Thu, 23 Nov
 2006 16:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756350AbWKWPzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 10:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757397AbWKWPzJ
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 10:55:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:17560 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1756350AbWKWPzI (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 10:55:08 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kANFsvG7031732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 23
 Nov 2006 12:54:57 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kANFsv9h005228; Thu, 23
 Nov 2006 12:54:57 -0300
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> Horst H. von Brand schrieb:
> > I did:
> >   git clone http://gondor.apana.org.au/~herbert/dash/dash.git
> > and got:
> >   error: Unable to start request
> >   error: Could not interpret heads/master as something to pull
>=20
> It works for me with both the version of git that came with Ubuntu 6.=
10
> (1.4.1) and a self-compiled git 1.4.4.g5942. :-?

Here it's git-1.4.4 (self-built from Junio's SRPM, on Fedora rawhide i6=
86).
--=20
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
