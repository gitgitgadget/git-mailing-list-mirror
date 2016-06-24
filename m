Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.5 required=3.0 tests=BAYES_99,BAYES_999,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00DE31FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 20:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbcFXU3N (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 16:29:13 -0400
Received: from mail-db3on0115.outbound.protection.outlook.com ([157.55.234.115]:63051
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751175AbcFXU3L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 16:29:11 -0400
X-Greylist: delayed 1811 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jun 2016 16:29:11 EDT
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=englishgolfunion.onmicrosoft.com; s=selector1-englandgolf-org;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3gMtPOvM4l0h2tX1w3Mxd7SQv0lGkrMskclR1lbjJVE=;
 b=QQ1SFRkzJV86jha9evUKM+Z/ZdKESAygaR5FgBEYayKnHLUFV8XAEpD9NQMi7h6eAAOHBgYQfmH37E24AOzEIn7yGeuYp+yyO3E9RwWzS3H1QyIncasZvltXc22qxsEWPEaL3zgzKyUCKHmCQVvH4Jatit4ipz3DMVGsMPaxZUc=
Received: from DB3PR01CA0037.eurprd01.prod.exchangelabs.com
 (2a01:111:e400:9400::12) by AM3PR01MB1219.eurprd01.prod.exchangelabs.com
 (2a01:111:e400:5876::13) with Microsoft SMTP Server (TLS) id 15.1.523.12;
 Fri, 24 Jun 2016 19:58:56 +0000
Received: from VE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e01::208) by DB3PR01CA0037.outlook.office365.com
 (2a01:111:e400:9400::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.528.16 via
 Frontend Transport; Fri, 24 Jun 2016 19:58:56 +0000
Authentication-Results:	spf=pass (sender IP is 185.113.82.3)
 smtp.mailfrom=englandgolf.org; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=englandgolf.org;
Received-SPF: Pass (protection.outlook.com: domain of englandgolf.org
 designates 185.113.82.3 as permitted sender) receiver=protection.outlook.com;
 client-ip=185.113.82.3; helo=mail.englandgolf.org;
Received: from mail.englandgolf.org (185.113.82.3) by
 VE1EUR01FT020.mail.protection.outlook.com (10.152.2.234) with Microsoft SMTP
 Server (TLS) id 15.1.523.9 via Frontend Transport; Fri, 24 Jun 2016 19:58:55
 +0000
Received: from VARADORN (203.146.251.69) by mail.englandgolf.org (10.0.0.16)
 with Microsoft SMTP Server id 14.3.123.3; Fri, 24 Jun 2016 20:43:56 +0100
From:	"Peter K. Durst  -  ." <clubservices@englandgolf.org>
Subject: Loan offer for Projects Finance (1.5 -1).
To:	<git@vger.kernel.org>
MIME-Version: 1.0
Reply-To: <aledrynov@gmail.com>
Date:	Sat, 25 Jun 2016 02:43:30 +0700
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-ID: <a0e5c6e7-7488-4f7c-a668-ec91c49b42f8@EGDCEX.egu.local>
X-Originating-IP: [203.146.251.69]
X-EXCLAIMER-MD-CONFIG: 51c184b6-034e-43bf-a22b-b7f28aa8b17a
X-EOPAttributedMessage:	0
X-Forefront-Antispam-Report: CIP:185.113.82.3;IPV:CAL;CTRY:;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(7916002)(2980300002)(438002)(199003)(189002)(77096005)(106466001)(66066001)(31696002)(47776003)(101616003)(2351001)(229853001)(107886002)(33646002)(110136002)(189998001)(50986999)(50466002)(9686002)(69596002)(450100001)(54356999)(2860700002)(8746002)(104016004)(53806999)(8936002)(6806005)(87936001)(19580395003)(98436002)(68736007)(11100500001)(2906002)(4001600100001)(586003)(3846002)(6116002)(356003)(8676002)(81156014)(81166006)(26826002)(31686004)(15974865002)(7736002)(23676002)(7846002)(97736004)(305945005)(43066003)(215113005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM3PR01MB1219;H:mail.englandgolf.org;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-MS-Office365-Filtering-Correlation-Id: 29d0b550-b9e2-49a0-9e44-08d39c69f95e
X-Microsoft-Exchange-Diagnostics: 1;AM3PR01MB1219;2:Bnrg9unrrQKa1Gzkl1i2j/639uUPDp6Ymz2UBejDmnTtMioObF9ZeuQ6htXNftGNAMQRLWhS09LKDG5YIYiPqDxcbRi+1H+KVxDp5pIhQdzHQqP/WNenLV23eFuqCv0o0z1vyA5SBevtnABOKm6Y5WxdAHmTJ07rqG5skolosnw58pFsbiouTu7jUDhMdb4H;3:ra6mWKx7M1tZdTf6EmrmjbgpwcuK1pFRhP8IdMKkoelnE2eQsqvcdCE6n1gG8MGIeCiinnAIV2GmV3KvwRGgoXhHzSD2lvnFVN/NlxnT8rKsc8fwVqgaceH+P/alpZ/qLWkQwU0fbWUOTC/pVBO4hrInVPXR0SQ2ur4kzUrvp4SfwzT2HHapC32Thm7ZgYCI+vlmub8Q2O67IN8oKzruLa+g2XmIfctvmhmE8+QPkVaNN3Kk38bsnkHPuBmL1WjY
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:AM3PR01MB1219;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR01MB1219;25:lEi1mW5KGCed0VTdqnOMDZkK2j6llqfQmWiXfQAoQ2AaJhdcPJCKg1dPlpQL+TcavZv039VY0cSdDjarDBp7SNxz3QQ8IZlp2zNjhYsiWYRdHDl/PEwyUMqUP+a5UlA44gsguNQQf9UipVArjVwcMXnM3jyyEH9HP81DM649E0s4tpL4/0yhaStuBnta9Eso7Dfwp+l3bq9mqfx95hMpvIoNskuIcn4ktfGLiWtKky/cmozfZ0F9x66BBI/uUzA6n75jDjN4u5ZwyOUNJ5m4rxhEzm5XBoBPbxZcweIwi3CIFbgWZiv0yUIJ5wqkI+VtzUoccwemxUPRqemU7OhCffUnQAUJ+5oFaOmh9up3pdmcakIYgchA5vpSl/zuIZToSrdxGHDQsvDbB+h/D8OzfmrDiroYFhmBQFD9mgG2K1T7GplOudmAg4AbNhEAGyiykEYDIYt2MlrcS9v3Ufdg6CP1AUSAn00aYUoRwWtEwCE3Jf5Osx5/PW+XQCJbP2i4DBgthg22hZrAeMiOV2WA9Np8DsVDKAUHOom/nnDxLOk8pJTpupg0i4os/CHnljMl6/Sy+pwLw1/9sDVM1LWKEke+NMsrRaAZqmayqfcElDao4YS2XMn+an7GMm94Q42IPyADI3BC/UV+ZOvAGmCPnz2ZbidUu4Q8Venr1k+WTiReMaXC4Qb/+RcMXIgBBeEUW20idtXQIkW2As7+HGyUt50HJ9ARlXpTIpDy+u7crvEZc4cyiWncyZKBRJP+74VD/Fee/WG5llUuZhYNA64GPiJwVuhsrRodDMXF6sZ/Yugxi2DQJFB0fc2ubT4DhQQ+8hDa6AReQz0wISSctQjIzmUkuP+eIH/ztehjg6c6mRd9yoTj6qd6EFU//UA8EOp7
X-Microsoft-Exchange-Diagnostics: 1;AM3PR01MB1219;20:uWKDp5RifVqHbW6Ao2Ok7IUWlAb03aiy17NdJK+7yRii0T+nrTIguDEuyT4l7JwSsW4NMCf7ffeA4LNaZ2DVlLwVnVxCKxU/apkmxMHiQzAkk7YTGP02vqhcCU7XJNKWNx616PFqV/GxHVDRa01VHHepBRDYr98caL1WXwBwXjs=;4:Wt/5KX9Bl+OUp8Zw80Uzd16uNcc/5B2LdfTXfe6EpvzhIgQdPG4UfIwPKJC27OxynIgpnRNoaQ6N2aplrV9DDUuxpTGPkXqZL63uqrEpFx0u8JlQMalLZDoHpmGOGa51KRNa1bp3hxkd3RpLsXeDi1Kt78mw/gd25bX5b/zRRshGSMHh4SS+rsSdgoukPLch1F21eug01bi3EfLJKbjMk4DSel6qwTIijBm0lwbCxvS66fdmeMbFmlS777VY/p4RKGVhi58F2K5IOD7o3bGhSDT8wXYjdcmae58Sg87kqgq+lAyFDA76m5PbWoBIaYli/HsacWAwPGmgKOq2KpyCcevv20bg/RfnEYFyd7BvqG9Qfj3sj/L7qcz79ZIKUvWWNNIXjnNv325OyIV4ktODaoFZ7Pas7yMPlT5WaBXundmm7f94akgtqPZEmwJ+hMPdZqCx3rsc8I/WcZNcyPTrKtFzCA6FBrb7fio11enKqnytOa+buzDgSNdG8ubygYA4Krcpl6obQewfCFKvdhXuzCpH6O30UuSrMD0q20Op24mqTLvlKywBXMk2e8+m7C3grCJUqolykm2SRBq/0XFN9KGHKcQA0uDudVPaCbk8LSFa2OsJLV/q70vz9Xn4oQuQLwngYhyX+JB+Pfl4o1M9IH007ANOqLzuyvONAB8Yuns=
X-Microsoft-Antispam-PRVS: <AM3PR01MB1219DDA90052D0FEB341186BFF2E0@AM3PR01MB1219.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(148322886591682)(31418570063057)(86561027422486)(81227570615382)(5213294742642)(64217206974132)(162078923652245);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(13013025)(5005006)(13023025)(8121501046)(13021025)(10201501046)(3002001);SRVR:AM3PR01MB1219;BCL:0;PCL:0;RULEID:;SRVR:AM3PR01MB1219;
X-Forefront-PRVS: 0983EAD6B2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTNQUjAxTUIxMjE5OzIzOlUwbzIvdlQvaXVvT05zQjNsaFVCSTF5MjVB?=
 =?utf-8?B?N1RORjZUbm5VL3FNZERzMVM4Vnk1cUc1VXVodTE1T0Y2dWdLNC9BZUMrMyth?=
 =?utf-8?B?NlpGQ05CZHFpaUI0bjQ1UE85d04vZGZjOC9xYW42cndvTzBieXF3N3E3K2I2?=
 =?utf-8?B?S3ZvYW1OQlhzRGJ4VGJmYkN5Q1NpVTdhMS84bDJidGJpT1V2eWNmZG5Dakln?=
 =?utf-8?B?ZWJWV3lObDErdlB4UTJkRHd2NUVnbHdwZHFKMWtMQ0k4UW5haGVJV2VxaEpz?=
 =?utf-8?B?bitxcVBrVkorckExd2ppcDFyVHJ0dm45U29rYi8vNGJjZHNYSHRlZmRWUnVI?=
 =?utf-8?B?anFhWW8vbEtUY1JwaWNsTGZ3S0JtRTF3VmRXR3dqQjFrd0VzMHhsdFNPZSs0?=
 =?utf-8?B?TmR1RWU3ZmRzVWRWVkh4a3dtUVhKNXUvYmtjVGIzWDA0Y01mcFlYcHlwbTh4?=
 =?utf-8?B?M2ZQUkhGTEh0ditnQUpxSUxFUkF5TnlZNk9lRThTZHhlU3cvMnhRVy9CSldD?=
 =?utf-8?B?VVlQWVBURktEK2p5NFd4YUtHWllJV0VvcE80ZmZHQlRqUlFVWGh2dUkzaUhN?=
 =?utf-8?B?UEdCY3o3bVp2YytXRXpNd3VqSitvQW9sL0lIUTQwNnVkY2owamEyM2psellr?=
 =?utf-8?B?dFp2NVRzYjAyRE96clRKMmFsd3RjdWxQQ3B5WmlFYkJNMUVKWUw2UkpkVDNh?=
 =?utf-8?B?aXNTcmsva2k1c0F6S0ZPdUt6YU1YZXVGS3RWWUtRSWJtSDlWNHU4S2J4Mllk?=
 =?utf-8?B?TkJvQXpJNTJ2TlphVUpDVlRJYlo1Vm5VbjhGMUxJc1g2aEZqbWd4dUV4ZzNE?=
 =?utf-8?B?UXlpdC9MYm1aV2tzN0RGSjdYUXJoRWlJRGF1ZzltSjZ4Y2ZxQWxvMlcxbHpR?=
 =?utf-8?B?TVdWd2E2bkFMMmM4SnpMOWJHWXR1amhPWXhKSGdYcDUvbDA5blM2aVlXT3BQ?=
 =?utf-8?B?a1YzNE93cENoNTczWnZPUTg2NjBQTzJlMDVtb3l0UGZyMG05dTFmS0JqWXA3?=
 =?utf-8?B?RGphd2ZmSzN5ZGRPY3V4NEtCQTNDL1V1RTJrQmtta04xcUZ4cWhMQmVHRzVy?=
 =?utf-8?B?aHc2RTJwL1ZCQTJoSWR3QnNCZ1V4cHVBMC9iMGZxSGJKb2lZTkdFTS94TWFS?=
 =?utf-8?B?ZWx6dVZkMWN4QlBPRjUyUDFqb3Bjdmk4OFlzMlRlZHYzVlA4K0N3RVVaVUdR?=
 =?utf-8?B?Qk03YnpqVE1JN0pUOE4wK1N5WmJrWklwZGlQV2E4UEZqOXNrMFNWb0JMa2Nz?=
 =?utf-8?B?VVRyZXVOTmhqamdTaUxXNFA5ZDZQczhma3cxdFdZRUl3d0ZMR2NWQmZPNFZG?=
 =?utf-8?B?RTdkMEV1SmgwakRuWUttN0JhWDBXSUhrK2VETDJlZmZSS1J6K014R1cweUY4?=
 =?utf-8?B?S2lCV1JUTGVyZERNY2tQY3lQSFNiMlhqVUJMUVp3aUk3OXBUK0x2T0ptNE1o?=
 =?utf-8?B?TmxNQmhhdzNwK2ZEdFBYV1pKVU9JNHhmaTdaZlJveS8ya2dpZEwycG9TVGZE?=
 =?utf-8?B?d2F2NDAxVUNSOGxVczhhdFRXSHczaEhHK2liM3VLZi8vWlczTXI3dCt1aDRt?=
 =?utf-8?B?aHVRQjREdlFQZXZ2V2k4RDhiT0JzMXVEbHgxdEhhNzhJdUFNdWloYm8vUGlr?=
 =?utf-8?B?K3NDa1l0SFRjSmJXVEVmK0JLNFUzR3gwcGFFMzJrV0NGU1FTY1poWGVvUU5V?=
 =?utf-8?B?OXhUR1BxQ2dabVNRQVloK0plOXZiaXA3UWlzdjdEUEM0OGpRVzhQdEpQaG12?=
 =?utf-8?Q?MwtFAmXp/x1ZMQ0s6jJ57nr3E49wzG68VW6cw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR01MB1219;6:f6Bi3/THLATbWtWzovrPzK48BeWs896EwD7uBoX1tiJtP1DO/El8p0C1DDhlllqRXQPsdX9pQB4WE1qqjN2Mpl08oZ0TK2XQDSovAafriirVpf6Xw2Cg1aNNR08H8W7PFjB3aauFEx5lM1WHaJhQQiP8zz6HzYmiXWplB6ngGQqKdwd9DZ44pJi14ZReFB61mW1AGH/JWahCaKMYsmZOqBScQ0ATFJhMEc+mLqIYuktk9uwFvDSMBHU3LRjpWdaeUQikt4Jy3jrg3qsQXk64zi2ceHWZ26lTBfhFV/Eq6mo=;5:dJKp5BbOAYE0hDlOJaVTHZ06GKzMIK1Ox+AinobJlllo+qcIaJcgdjvMFh8yLmyWrGVYdiFgyMOSadBh+Y9Yft2fQC30QVGhhqvKR8ETgt/iCvzOk0Sev8mJsUlf3pGRKXb7g+L/I9jgnSQKpGzzMg==;24:YXYMOrIZY6f1QGyVyXw50Es4+XoeW6yG+kSVNKufMkRlLp7Uimq46eBnLiUhFPeJF+WEI2qrHre7PgHlkSBYhtl6TCeEtJZEibJLd6gdKck=;7:+KL7PndGsGjAC0EmBwQdJbylWAXa3tN+c73jCTshBsWD1UguTPrBpm9E+xPWx7wfTDpFcGoS/czMGMkvNA5ONCao7p6v2m6OSRIrQyC3KxNx5ON8labcQ1YE7eCdTpAw8ubX6wXHTNTPF1nUY6ksK0z+SlC5l7TlTkLu+coninEo+LZR+pnh43aSpnhU7IHwEb2l1Owz3f/eEkIuyvqHBL5Y3tGpChQL63XeNeVQ8bdHDsAPJNKJhowZnScJZxTy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata:	NSPM
X-OriginatorOrg: englandgolf.org
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2016 19:58:55.7504
 (UTC)
X-MS-Exchange-CrossTenant-Id: c77dd947-aff3-4e84-a21d-cc0064ec13fe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:	TenantId=c77dd947-aff3-4e84-a21d-cc0064ec13fe;Ip=[185.113.82.3];Helo=[mail.englandgolf.org]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR01MB1219
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

﻿Sir,

I am a retired banker, currently working as a consultant.

By virtue of my past working experience, I have contacts to high net worth Individuals and Investment firms in need to place funds into different projects to generate profits. The funding would be provided as a soft loan at 3% Return on Investment (ROI) with minimal documentations required to complete the funding modalities.

A commission of 1% is paid to the Intermediary/Agent/Broker who introduce project owners for finance.

I anticipate your reply.

Yours faithfully,

Peter Karl Durst




Club Services
Participation & Club Support Department

England Golf

Tel: 01526 354500

Web: www.englandgolf.org

Follow us on Twitter: 
www.twitter.com/EnglandGolf

Find us on Facebook: www.facebook.com/EnglandGolf

The English Golf Union Ltd is 
a company limited by Guarantee registered in England, trading as England Golf.  
Registered number: 5564108. Registered Office: The National Golf Centre, The Broadway, 
Woodhall Spa, Lincolnshire, LN10 6PU.

If you are not the intended 
recipient, and disclosure, copying, distribution or any action taken or omitted 
in reliance on this is prohibited and may be unlawful. If you have received this 
message in error, please notify us and remove it from your system.  No 
liability or responsibility is accepted if information or data is, for whatever 
reason corrupted or does not reach its intended recipient.  No Warranty is 
given that this email is free of viruses.  The views expressed in this 
email are, unless otherwise stated, those of the author and not those of The 
English Golf Union Limited or its management. The English Golf Union Limited 
reserves the right to monitor, intercept and block emails addressed to its users 
or take any other action in accordance with its email use policy.

