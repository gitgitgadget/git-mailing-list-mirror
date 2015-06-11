From: BGaudreault Brian <BGaudreault@edrnet.com>
Subject: RE: proxy_windows_386.exe Firewall Notification
Date: Thu, 11 Jun 2015 19:57:44 +0000
Message-ID: <BLUPR0701MB1969F0D63174D70566496694D7BC0@BLUPR0701MB1969.namprd07.prod.outlook.com>
References: <BLUPR0701MB196906E314F2F1083B5DEC2BD7BC0@BLUPR0701MB1969.namprd07.prod.outlook.com>
 <20150611224305.ac126629f69dbb915bdc8851@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Thu Jun 11 22:18:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z38vx-0001Tu-5W
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbbFKUSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 16:18:18 -0400
Received: from mail-bl2on0082.outbound.protection.outlook.com ([65.55.169.82]:65408
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933244AbbFKUNe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2015 16:13:34 -0400
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com (25.163.121.20) by
 BLUPR0701MB1971.namprd07.prod.outlook.com (25.163.121.22) with Microsoft SMTP
 Server (TLS) id 15.1.184.17; Thu, 11 Jun 2015 19:57:44 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com ([25.163.121.20]) by
 BLUPR0701MB1969.namprd07.prod.outlook.com ([25.163.121.20]) with mapi id
 15.01.0184.014; Thu, 11 Jun 2015 19:57:44 +0000
Thread-Topic: proxy_windows_386.exe Firewall Notification
Thread-Index: AdCkbWnQka317D+AQMy6hcSJKdL0RAAEWvGAAAB1QmA=
In-Reply-To: <20150611224305.ac126629f69dbb915bdc8851@domain007.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: 007spb.ru; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [12.188.185.200]
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1971;
x-microsoft-antispam-prvs: <BLUPR0701MB1971A867D1020AE410CC765AD7BC0@BLUPR0701MB1971.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(520003)(3002001);SRVR:BLUPR0701MB1971;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1971;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(377454003)(61484003)(51704005)(24454002)(13464003)(86362001)(40100003)(92566002)(122556002)(80792005)(33656002)(74316001)(46102003)(62966003)(77156002)(2900100001)(102836002)(5003600100002)(2950100001)(189998001)(5002640100001)(19580405001)(19580395003)(5001960100002)(76576001)(5001920100001)(99286002)(106116001)(2656002)(87936001)(76176999)(50986999)(54356999)(66066001)(460985005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1971;H:BLUPR0701MB1969.namprd07.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-OriginatorOrg: edrnet.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2015 19:57:44.0988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5294837-2991-446b-82ba-9a6e606fbfae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1971
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271460>

Lol, sorry.  I meant to post in the Vagrant forums.  Too many projects going on at the same time!

-----Original Message-----
From: Konstantin Khomoutov [mailto:kostix+git@007spb.ru] 
Sent: Thursday, June 11, 2015 3:43 PM
To: BGaudreault Brian
Cc: git@vger.kernel.org
Subject: Re: proxy_windows_386.exe Firewall Notification

On Thu, 11 Jun 2015 17:46:58 +0000
BGaudreault Brian <BGaudreault@edrnet.com> wrote:

> Hello, when connecting to a Vagrant Shared VM via SSH, I'm getting a 
> Windows Firewall prompt about 'proxy_windows_386.exe' (in C:\Program
> Files\hashicorp\vagrant\embedded\gems\gems\vagrant-share-1.1.0
> \localbin\), which looks like a malware-type name.  Here's the
> message: "Windows Security Alert.  Windows Firewall has blocked some 
> features of this app.  Windows Firewall has blocked some features of 
> proxy_windows_386.exe on all public and private networks.".
> 
> So I did a quick search for this file name on the Internet as well as 
> the Git-SCM.com/community site and haven't found any clear 
> explinations about what this file is and if it's safe.  If this is a 
> legitimate safe file, I think it's important that this is clearly 
> documented in the Git documentation.  Can someone verify the details 
> about this file?

I fail to get how did you manage to connect "proxy_windows_386.exe"
with Git.  Care to elaborate on this?
