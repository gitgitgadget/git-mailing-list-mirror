Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB131F597
	for <e@80x24.org>; Wed, 25 Jul 2018 13:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeGYOUk (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 10:20:40 -0400
Received: from rsoutemea1b.hes.trendmicro.eu ([52.48.127.233]:36458 "EHLO
        rsoutemea1b.hes.trendmicro.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728902AbeGYOUk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Jul 2018 10:20:40 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jul 2018 10:20:37 EDT
Received: from 0.0.0.0_hes.trendmicro.com (unknown [52.58.63.27])
        by rsoutemea1b.hes.trendmicro.eu (Postfix) with ESMTPS id 1C3D85D372D
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 13:02:20 +0000 (UTC)
Received: from 0.0.0.0_hes.trendmicro.com (unknown [192.168.13.218])
        by routemea4.hes.trendmicro.eu (Postfix) with SMTP id 6CEAB456082
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 13:02:18 +0000 (UTC)
Received: from Lincexchange2.dynexsemi.com (unknown [195.26.60.67])
        by relayemea2.hes.trendmicro.eu (TrendMicro Hosted Email Security) with ESMTPS id BD3D458C04E
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 13:02:17 +0000 (UTC)
Received: from LINCEXCHANGE1.dynexsemi.com (172.16.10.19) by
 Lincexchange2.dynexsemi.com (172.16.10.12) with Microsoft SMTP Server (TLS)
 id 15.0.1293.2; Wed, 25 Jul 2018 14:02:17 +0100
Received: from LINCEXCHANGE1.dynexsemi.com ([fe80::f814:9d4d:e87:b4cb]) by
 LINCEXCHANGE1.dynexsemi.com ([fe80::f814:9d4d:e87:b4cb%14]) with mapi id
 15.00.1293.004; Wed, 25 Jul 2018 14:02:17 +0100
From:   David Hind <David.Hind@dynexsemi.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Using Git for applications other than code development
Thread-Topic: Using Git for applications other than code development
Thread-Index: AdQkF7ZfBuTCgIwnR16U9l5S9KTkZQ==
Date:   Wed, 25 Jul 2018 13:02:16 +0000
Message-ID: <4b9575bf039e46cd9dc150111916e734@LINCEXCHANGE1.dynexsemi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.16.22.15]
Content-Type: multipart/alternative;
        boundary="_000_4b9575bf039e46cd9dc150111916e734LINCEXCHANGE1dynexsemic_"
MIME-Version: 1.0
X-TMASE-Version: StarCloud-1.3-8.2.1013-23990.006
X-TMASE-Result: 10--14.751800-7.000000
X-TMASE-MatchedRID: GWjTRNzKVstJuVlaxd7wf6ZCFtxq3n99Y3xj9ekRaAvSpXlDA2zQ36wd
        d14j6nTyqJKChTBUoXbwo358o3n9LXxplJvxMaCicFEiuPxHjsWeimGtNywjtsLDncHoPV1T6sS
        JFJmSQR+PuBEG8JkFiBB6x3DoS/ksJEkR898EcsarhCEFTnVAD6vd3WuZF0KAgwAxxxH8Mzp9VE
        N05cAupHFTafZcmp6O5saoGwUzKRAmh4/l0NtpS5RrnSy7UTtbtJOx7oLcpUhV84HrPxCfbK9Zj
        Ar+wzbbNXy+IDNSabQEPPpUYXwvLAqinms2D2HCGYJhRh6ssesLTBRg82kMWtvBgCEp+Aoi7/+9
        swuISRVLbeMXCgjtvX7W5bdwgnW8o5RUoF1j1rj1NV6ZtjddkvwGVtfL479aOoj9DXM40dJb6/S
        bnJwGr85B/9LVe+0QGbbQdh/kTL+djhu5pFVIp7qQyAveNtg60zEP/d7xPF1G2qlFbyxbItrPdr
        IdM42b2X0MdweWjLiSU848M/hs6K4QAeQvIGeqNNHZMWDTEbcl3afZehJEWdBfyqisXYsPvr4Xz
        NrRszb3aCtTBCBhl3k48PxckV+kHxPMjOKY7A/+xOhjarOnHgGlEJORGTlJtVX2a1/ZsViQh+7G
        CWI5YG1JwhYTSYBwd8gk6jBaXQdvdRORsvXbX9vikzaPj783NACjOuV1vrPTaS14fHrbcSHjY9X
        ZctwI9UOA7doh5RQ=
X-TM-Deliver-Signature: CC7C6C82782A08F59DDCF5AADD6209B0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_000_4b9575bf039e46cd9dc150111916e734LINCEXCHANGE1dynexsemic_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I work for a company that is looking to adopt VCS and I like sound of Git (=
although I have no experience of using VCS). My question is, everything see=
ms to be directed towards code developers. Can I use Git to do revision con=
trol for other types of design document? For example electrical circuit des=
igns, circuit PCB designs etc.?

Thanks!
David

________________________________

Dynex Semiconductor Limited.
Registered in England and Wales: No 3824626
Registered Office: Doddington Road, Lincoln, LN6 3LF, United Kingdom

This e-mail and any attachments are confidential and may be privileged. If =
you are not the intended recipient please notify the sender immediately, de=
lete the email from your system and do not disclose the contents to another=
 person, use it for any purpose or store or copy the information in any med=
ium.
Whilst we run anti-virus software on all internet emails we do not accept r=
esponsibility for viruses and advise that in keeping with good computing pr=
actice you should ensure this email and any attachments are virus free.

--_000_4b9575bf039e46cd9dc150111916e734LINCEXCHANGE1dynexsemic_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I work for a company that is looking to adopt VCS an=
d I like sound of Git (although I have no experience of using VCS). My ques=
tion is, everything seems to be directed towards code developers. Can I use=
 Git to do revision control for other
 types of design document? For example electrical circuit designs, circuit =
PCB designs etc.?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks!<o:p></o:p></p>
<p class=3D"MsoNormal">David <o:p></o:p></p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Black" size=3D"3"><br>
Dynex Semiconductor Limited.<br>
Registered in England and Wales: No 3824626<br>
Registered Office: Doddington Road, Lincoln, LN6 3LF, United Kingdom<br>
<br>
This e-mail and any attachments are confidential and may be privileged. If =
you are not the intended recipient please notify the sender immediately, de=
lete the email from your system and do not disclose the contents to another=
 person, use it for any purpose
 or store or copy the information in any medium.<br>
Whilst we run anti-virus software on all internet emails we do not accept r=
esponsibility for viruses and advise that in keeping with good computing pr=
actice you should ensure this email and any attachments are virus free.<br>
</font>
</body>
</html>

--_000_4b9575bf039e46cd9dc150111916e734LINCEXCHANGE1dynexsemic_--

