From: git-owner@vger.kernel.org
Subject: Re
Date: Mon, 10 Aug 2015 22:15:59 +0300
Message-ID: <1287a51e-5133-4ad1-97fb-7970e1cf519d@FSU-EXCH-NWR02.fsu.edu>
Reply-To: <melcoxc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Recipients@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 21:18:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOsa9-0003s1-T5
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 21:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbbHJTRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 15:17:54 -0400
Received: from mail-bn1hn0251.outbound.protection.outlook.com ([157.56.110.251]:1507
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754494AbbHJTRv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 15:17:51 -0400
Received: from BN3PR02MB1125.namprd02.prod.outlook.com (10.162.168.143) by
 BN3PR02MB1221.namprd02.prod.outlook.com (10.162.168.23) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Mon, 10 Aug 2015 19:17:48 +0000
Received: from BLUPR02CA033.namprd02.prod.outlook.com (10.160.23.151) by
 BN3PR02MB1125.namprd02.prod.outlook.com (10.162.168.143) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Mon, 10 Aug 2015 19:17:47 +0000
Received: from BN1AFFO11FD018.protection.gbl (2a01:111:f400:7c10::125) by
 BLUPR02CA033.outlook.office365.com (2a01:111:e400:8ad::23) with Microsoft
 SMTP Server (TLS) id 15.1.225.19 via Frontend Transport; Mon, 10 Aug 2015
 19:17:47 +0000
Authentication-Results: spf=none (sender IP is 146.201.58.209)
 smtp.helo=fsu-exch-nwr02.fsu.edu; yahoo.com; dkim=none (message not signed)
 header.d=none;
Received-SPF: None (protection.outlook.com: fsu-exch-nwr02.fsu.edu does not
 designate permitted sender hosts)
Received: from fsu-exch-nwr02.fsu.edu (146.201.58.209) by
 BN1AFFO11FD018.mail.protection.outlook.com (10.58.52.78) with Microsoft SMTP
 Server (TLS) id 15.1.243.9 via Frontend Transport; Mon, 10 Aug 2015 19:17:45
 +0000
Received: from user-PC.home (154.122.202.81) by fsu-exch-nwr02.fsu.edu
 (10.146.58.166) with Microsoft SMTP Server (TLS) id 14.3.235.1; Mon, 10 Aug
 2015 15:17:03 -0400
Content-Description: Mail message body
Illegal-Object: Syntax error in From: address found on vger.kernel.org:
	From:	Ms.CatherineMelcox
				    ^-missing end of mailbox
X-Originating-IP: [154.122.202.81]
X-EOPAttributedMessage: 0
X-Matching-Connectors: 130837078664685078;(24ac9bd0-d052-4624-b856-08d183bcd924,338318b9-ba1c-43c0-8ef6-08d183bcac80,974605de-b42d-411a-3448-08d12e412d02);()
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD018;1:Aj4+xYItqQL08VOuBFivhhrDKHMLOvhWJEmOKBzhzzWYLnpTmb8ffO3kNMP5bJk6Of/veFT0i+uWq6e/udEaEGih91a6rBWt2dm1Feky1b+s3WEov8fpVZr7MXqY14bQ3UVVxNgRRibnm5U/ib1XnMt53+eN6Pd6YJ7ulsi2vrAhOnAeqgKfr3DZkaVRFJuai2weIUpX+vNeWItnWBfJ175g9dKcIaAJ3KRxX/m0aof0VZ2L3CGw3668slyjfB4Qfkw5Fm+SDiN0hTvvSErfXjAhiWQjUw0XMGTOEoc2FxYJXgHa1JL0G44ZXllMjc/4yRKREk13ojlI7yYZf30KAfEYmgxdFjoOu0SFHGl4FtMOKZj9lMXwlvtqOoui0q30nT6Sv8UCQkpj7n1kcDFmIV7pX+cxcDZ6naI0BDgpvlOgM3yGxO+yJ9YjrtrbvMsD2qhNJA0844UPDTmMHSCesgC8UQZyCN+o+rrQdBDDfutFD13zHdfRPR7CiRKXGvXe
X-Forefront-Antispam-Report: CIP:146.201.58.209;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:SPM;SFS:(10009020)(6009001)(2970300002)(428002)(189002)(199003)(5001860100001)(6806004)(19580405001)(50466002)(64706001)(87936001)(221843001)(109986003)(4001540100001)(77156002)(250100001)(66066001)(17643785005)(107886002)(19580395003)(33646002)(221173001)(26826002)(62966003)(4001450100002)(229853001)(78352002)(77096005)(31686004)(4001600100001)(46102003)(960300001)(47776003)(5005630100001)(71816002)(189998001)(46552002)(5001920100001)(110136002)(558084003)(23756003)(31696002)(221733001)(43066003)(104016003)(105586002)(101416001)(5001830100001)(54356999)(53256004)(53806999)(106466001)(42382002)(50986999)(32000200001);DIR:OUT;SFP:1501;SCL:5;SRVR:BN3PR02MB1125;H:fsu-exch-nwr02.fsu.edu;FPR:;SPF:None;PTR:fsu-ex
 ch-nwr02.fsu.edu;MX:0;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1125;2:PYP54EU/hwL98qb2bbn4kRtH9OabeZWzlwqRVEJfnBHGh0xax6/oGT9Dx92LA9raJeaiUBEjVsXn+0hqbMDesbypKWQJBI3jyYKX/NCULlZ6AVbeKnlK/UaBg2WY1kRnJ25cl2DHK7Xyt9gY8Uilp8+0VRanQNShB5kHAWUe7K0=;3:y4CDJNAF1B225U1NItsyboR4e4eX9bonZ9X29BIFm8tPxC7Ok6X37hDiJxCU5gknIjSTeAkUbs+FUnJtFU2QN8IuGiD8xM6ONwBbFfJ2PUT24rM6IfZmeqnmqm+lmlSa95xUTYR6XPGlB7plTbhDQuLa39Vz+k7aSuHjBgyEMi/QpZxGOzFkXh1JJgms5RfU5W0geAH9WpeZ3kq7aJtR3/nLsnO3Y+Tttaj+4HSJwIHDObyiCfhOWgjsJRkYo/ZK;25:FeBzZIIBNYBJaC6e0YzVN5ggsv6+uPzoSCOrgf9R2xqaCUA890gX81piBdqNN6POWBJRGMF73H7PUpMvF7pu7TZu+Mr8AfWChcMxD5otWjhUSdfRKT8zx2Y53ux5vNvo5cxC9O4LNUh0RrAiJicsd3To1wY9qH3yolwnTG06UjYsXI+e1+3KbPoclQ0KWt8LNFWgnd+8M9kvKNTa6Oahu69tkeDX8v8HEo2U0er9gCf4khx2wLtDGK4w7WCQMbkruyi/5uNhwaom6SvNLibEWg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR02MB1125;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR02MB1221;
X-Microsoft-Antispam-PRVS: <BN3PR02MB1125568CE37DF6DE6B3B7323B8700@BN3PR02MB1125.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN3PR02MB1125;BCL:0;PCL:0;RULEID:(400006);SRVR:BN3PR02MB1125;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1125;4:UZTIOztbB89upbf1OroFPPST4fTTAwmw/Mvbex0pexH1ELH53eDwhCnJ55nJya39WHo8rcTycnyjYgCcevmRAZz4n42O6KeHQVOEFsys4Ig4lWRqsVS/dCfh0wuqkRuQVXM6tgmbMJ6USRwyoOMRlcDLR2iALPoc5bFJTtZfhpIM751Bxo31VOyuNrmS3I+oVo6E4XAZL+2PUgYPE2fhlPSqV4YVOf77QJiNR+yzSQRBeYPGgnT6gxxU1/Gd8X+cGglnP/PsuyN9TJfj5Oy6fw6YKT8FIkaOAVmHp0HIHMA=
X-Forefront-PRVS: 06640999CA
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN3PR02MB1125;23:rZfYtEV7+iQ5+qsXzmluEsgCRlizcE4n78ucLcx?=
 =?iso-8859-1?Q?Qz3sge8paJp5xaXoOeHF3iRlu0vfpQoEDPVZLmOQltm8EhrxzRy8lSy6n8?=
 =?iso-8859-1?Q?WiV74rF5aYsCK7dOEHn2GNtJuVWx0ry8B4nNMybF8WmaPIR0ZLHkWXHyTN?=
 =?iso-8859-1?Q?2vl+t3AoR70KhTdoAqjqwpp1QQcWq2aVQ8PHzl73AZRLpvdLvTrX5U4UJW?=
 =?iso-8859-1?Q?CYwJWVWhHhJowegjFPjzX4mpNjjbHBTbLNmTpr8mGOlriTZvS8Y3GjHebp?=
 =?iso-8859-1?Q?omHllASYboZKxVS0k69mZx7SL7nHyf9nyj3c0BGgC1hy3R2ToeiRy0Uisw?=
 =?iso-8859-1?Q?1sDH5gyAbY97QUjljS1W5XlLHz1oYytq2GdKKB1Wfv0JaOntwmCBKxIoGa?=
 =?iso-8859-1?Q?yb2LT5ym5+DjAsp/J06ieprAbKuLtXb3KMG1RfuNAto7wT00Gea7MYes5W?=
 =?iso-8859-1?Q?LyN9LX+3/G6Pko6hC8DziChx3pPc75bB9WxfR1VHhEyrAPGjMRkEwdS6VF?=
 =?iso-8859-1?Q?yleUYqkw2C4/SSUkCL5C8wWbAb9jbK3wRyfrR9upvE1L2ApX93/3XRWJm8?=
 =?iso-8859-1?Q?C/hZdRcGawWwIFXNh8Nd/Zjdt989zYEN3ADx6//4XJIsr7mLjoZaW8fiey?=
 =?iso-8859-1?Q?c5Kq 
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1125;5:NqFYVNDDnyeVtkaF48r4+c2ULjEhzWjO1a0Mr6Bm9qq0bV9Dkb40sJ/sNgzCf+fawzgbI2Ka378p61ydbdN6J2CzMp1v+MiGRd2sm3oG+grXfSQPD3jv3OduTIhyotZMdI/7JAtn5RRAOeHbDRVERfzqrQ5PHoKt351swD1HqdQ=;24:9G8UaxZs0iwjyuMYHRou6H1C6KDUrXvWzS72vHst6GpmRkrDzD1f+oR7Cs3YwzDu6s8nN8rZlAQjKtIG+oXEJw==
SpamDiagnosticOutput: 1:22
SpamDiagnosticMetadata: 00000000%2D0000%2D0000%2D0000%2D000000000000
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2015 19:17:45.8757
 (UTC)
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[146.201.58.209];Helo=[fsu-exch-nwr02.fsu.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR02MB1125
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1221;2:tmrT/9Tv6MErX/FMf7fEConkKHZeMrfG1ZS1+B5R6MnZtrgOx9Mb7lCgURiWnCB4fkCcM7b2ehOlVBVozS5Z8Fts6xFuWrTVbNng7zABkK/GLcL1rhF25aoL9N6/9q7CDwb7sW5l9Sy3+FlwHd+ta+zFM1kInARbsMpPOzjeIJk=;3:d9Imtk2+Rceti4KqOZZCvvOCEd5H/DSaCoIC/kpR81fAuEkimZ9+BonAiuat0jkzYBEylBabJBEGs9FTtruoLzyLMGpzhfuJg2jndSvGF3m+Zs7/nf+qUaCKgcCocVP9BBwj+jAPL6cez3dnjd594io01wGEhEEhTgAGkEHuN9bFc/vHU/7EWsNICgn+IPIhunELMZnLJmVPADjt9roY0pZERPUiuuh5hS7kWuiJBj9wKTp46RxyudqouNksU2JE;25:hs6hsY7TT52E1RG/fXzmwHOev2ztm83g5yR1TtqijQcAKqWRdkAbJ4DqItvnq2X0wMivbajt/j+xFuMAb+GuaYis9ac9yexB6uxgV+oj6QgLNEI+RH5Px2cXiKNsxWBjgNxLHEeIkbjYSgv0nrqb1q0SgtUTP8E+6R8QMxnDiAQYaBaja+bd89nrRzbkrnqy4fYXnlovhbdR3bAHF7fu+CiCQFuAeESIfX8d0jhasmcUjl3in+PQCYRVfx5JFr9Nztfui8Jjkw9dy7B1xB3akg==;23:RqQ455KR6f5rPC8/waeRO6RoLJ8+d
 GKgTU1XIbWl8WycMQm8jx5MoajTfJh6TfZIydIQv3o9xvMeBexyxkqjQCBSSGp/DmUaylc27pnMRBtJAucaADryA07o/U8FIFQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275650>

Your Donation to you is ready, contact melcoxc@gmail.com for more details
