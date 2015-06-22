From: Greg Ledger <gledger@glcdelivers.com>
Subject: config commands not working _Noobe question
Date: Mon, 22 Jun 2015 23:31:00 +0000
Message-ID: <D1AE04E1.1172A%gledger@glcdelivers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 02:04:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Bh6-0002rX-TF
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 02:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbbFWAD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 20:03:59 -0400
Received: from mail-bn1bon0113.outbound.protection.outlook.com ([157.56.111.113]:23428
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751900AbbFWAD6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 20:03:58 -0400
Received: from BN1PR05MB202.namprd05.prod.outlook.com (10.255.206.18) by
 BN1PR05MB311.namprd05.prod.outlook.com (10.141.63.147) with Microsoft SMTP
 Server (TLS) id 15.1.195.15; Mon, 22 Jun 2015 23:31:03 +0000
Received: from BN1PR05MB204.namprd05.prod.outlook.com (10.255.206.17) by
 BN1PR05MB202.namprd05.prod.outlook.com (10.255.206.18) with Microsoft SMTP
 Server (TLS) id 15.1.195.15; Mon, 22 Jun 2015 23:31:00 +0000
Received: from BN1PR05MB204.namprd05.prod.outlook.com ([169.254.1.235]) by
 BN1PR05MB204.namprd05.prod.outlook.com ([169.254.1.235]) with mapi id
 15.01.0195.005; Mon, 22 Jun 2015 23:31:00 +0000
Thread-Topic: config commands not working _Noobe question
Thread-Index: AQHQrUN/jKnkZSttr02w0ocmMhSE6w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.5.2.150604
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [50.254.2.17]
x-microsoft-exchange-diagnostics: 1;BN1PR05MB202;5:LVYfL9Qyq3AlIQDKRUcn+oyGRt0RlRkyQ12eZAkkmHcjUdcUkAYLD5suE1c2ynsRVORqAx6qm6+5Y/LZQhW4RbCo+sqIA0uyGL4+PbbHjsoDvombCXKdfXn/9TG2K1nBJBCNFXWTi26XsXkJtQ43Nw==;24:Yt8sVrVMLqgFKwYNA258K++fYW7qenNOYlUCHt6v5mgjUMZuc1yzamxcHmc69bcU8VNCMRRzIDxj2acjzIxe5V3iUgPb3orL/RraggXgRRw=;20:SmBR6bSKXEjgilchcS4zp/s29CKiRgJaNqr5L+rn0hT5zxY7ng8IPtzmXBCNowofyOaCwCJOjNN/6MJngCveJw==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN1PR05MB202;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN1PR05MB311;
x-microsoft-antispam-prvs: <BN1PR05MB2027C005EC4E7626218F4BDB1A10@BN1PR05MB202.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN1PR05MB202;BCL:0;PCL:0;RULEID:;SRVR:BN1PR05MB202;
x-forefront-prvs: 06157D541C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(46102003)(92566002)(83506001)(450100001)(2351001)(2501003)(229853001)(189998001)(54356999)(50986999)(106116001)(99286002)(36756003)(5002640100001)(77156002)(5001960100002)(4001350100001)(15974865002)(62966003)(107886002)(40100003)(110136002)(2656002)(15975445007)(122556002)(102836002)(87936001)(19580405001)(19580395003)(66066001)(85806002)(86362001)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN1PR05MB202;H:BN1PR05MB204.namprd05.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
Content-ID: <8CC8EC281154B44896E9432FBFAEAE0A@namprd05.prod.outlook.com>
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2015 23:31:00.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f7b1050-6293-417a-ae69-dc7603146b46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR05MB202
X-Microsoft-Exchange-Diagnostics: 1;BN1PR05MB311;2:p2Biz/KqVFiaQ5H3yJEuQRrt52+9j0VDuaBIlRl6+i6dhRTFcIEsjGVLnIohDntY;3:1vMvrE7zZ4MCwe7Hsq4aLqBRomRWvYJhBB/3YtAyBmfk0VdLyHvU114PUZddB1L1N1KMQk8hNJjKjrjWFGk4Qkp+xlzNXdIe+nxcq69Y4iZYdHnCRMONFnx30ajlPRzmfMhrAuk0Ba2yCwZbv+I/rQ==;23:zTcjTKF6Mv/1zCBL6xx7Hg6xlFUcBvjMJTu7j8tHOpQwt6franKlBlkW8buVR3KnzOMzXRk1d14J6dHVjlH59ixiAk6dfKCLJgDB8xpT323lvOSbHb3joKQZ0yWEyA2AaNglwhNm3koWMaGpDl/E2t8zFW1bIrh7OarSEnn4c50j7ljUEweMZHMmZqNIVDcIioFGxJpd/OMYns+s8SIC9Jv6To0r7oBZ9AAXpEaRNkCE1gRVvVZNcAQIiY6kLmEE
X-OriginatorOrg: glcdelivers.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272437>

after adding git config =8Bglobal user.name Greg Ledger and git config
=8Bglobal user.email gledger@glcdelivers.com, when I run:
source ~/.gitconfig I get

-bash: [user]: command not found
-bash: name: command not found
-bash: email: command not found
-bash: [color]: command not found
-bash: ui: command not found

What gives? (I had to download xcode tools before I could do my first g=
it
init

Greg Ledger=20
Web Developer & E-Marketing Specialist | GLC
847.205.3125=20
gledger@glcdelivers.com
www.glcdelivers.com <http://www.glcdelivers.com>
