From: "Knobbe, Fabian" <Fabian.Knobbe@landisgyr.com>
Subject: automatic git installation
Date: Tue, 12 May 2015 08:50:58 +0000
Message-ID: <AM3PR01MB3742DD43DFAE5196C50A572E6DA0@AM3PR01MB374.eurprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 12 11:05:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys68E-00011C-MM
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 11:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbbELJFi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2015 05:05:38 -0400
Received: from mail-am1on0136.outbound.protection.outlook.com ([157.56.112.136]:33280
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752807AbbELJFP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2015 05:05:15 -0400
X-Greylist: delayed 853 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2015 05:05:15 EDT
Received: from AM3PR01MB374.eurprd01.prod.exchangelabs.com (10.141.46.148) by
 AM3PR01MB374.eurprd01.prod.exchangelabs.com (10.141.46.148) with Microsoft
 SMTP Server (TLS) id 15.1.160.19; Tue, 12 May 2015 08:51:00 +0000
Received: from AM3PR01MB374.eurprd01.prod.exchangelabs.com ([10.141.46.148])
 by AM3PR01MB374.eurprd01.prod.exchangelabs.com ([10.141.46.148]) with mapi id
 15.01.0160.009; Tue, 12 May 2015 08:51:00 +0000
Thread-Topic: automatic git installation
Thread-Index: AdCMj++SoPlBjtveQ02hr4Z5DksLIQ==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [80.239.165.1]
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM3PR01MB374;
x-microsoft-antispam-prvs: <AM3PR01MB3749A0CB3F4024C76C572AEE6DA0@AM3PR01MB374.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:AM3PR01MB374;BCL:0;PCL:0;RULEID:;SRVR:AM3PR01MB374;
x-forefront-prvs: 0574D4712B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(40134004)(50986999)(189998001)(74316001)(40100003)(62966003)(19580395003)(2900100001)(66066001)(33656002)(46102003)(122556002)(19580405001)(229853001)(54356999)(86362001)(92566002)(77096005)(102836002)(2351001)(2656002)(77156002)(5890100001)(110136002)(107886002)(450100001)(15974865002)(5001960100002)(2501003)(87936001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM3PR01MB374;H:AM3PR01MB374.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2015 08:50:58.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR01MB374
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268848>

Hallo,

I would like to automatically install git with a script. I already foun=
d some command line arguments to pass my settings to the setup routine,=
 but I still don't know how to set "Adjust your PATH environment" to "U=
se Git from the Windows Command Prompt" without userinteraction.

Thanks for any hints!

Mit freundlichen Gr=FC=DFen

=46abian Knobbe
Landis+Gyr GmbH
Operation Support BL Heat
Humboldtstr. 64 - 90459 N=FCrnberg - Germany
Office : +49 911 723 - 7134
=46ax :    +49 911 723 - 5254
fabian.knobbe@landisgyr.com
www.landisgyr.com
manage energy better

Gesch=E4ftsf=FChrer: Dr. Peter Heuell, Herbert Brunner
Sitz der Gesellschaft: N=FCrnberg, Registergericht: N=FCrnberg, HR B 23=
 863

Haftungsausschluss: Diese Nachricht ist ausschlie=DFlich f=FCr die Pers=
on oder Einheit bestimmt, an die sie gerichtet ist. Sie enth=E4lt unter=
 Umst=E4nden Informationen, die unter geltendem Recht vertraulich, gese=
tzlich gesch=FCtzt oder von der Offenlegung ausgeschlossen sind. Falls =
Sie nicht der vorgesehene Empf=E4nger oder verantwortlich f=FCr die Wei=
terleitung dieser Nachricht an den vorgesehenen Empf=E4nger sind, ist e=
s Ihnen strengstens untersagt, diese Nachricht offen zu legen, zu verte=
ilen, zu kopieren oder in irgendeiner Art zu benutzen. Sollten Sie dies=
e Nachricht versehentlich erhalten haben, benachrichtigen Sie bitte den=
 Absender und l=F6schen und vernichten Sie jegliche Kopie davon, die Si=
e m=F6glicherweise erhalten haben.

Disclaimer: This message is intended only for the use of the individual=
 or entity to which it is addressed and may contain information which i=
s privileged, confidential, proprietary, or exempt from disclosure unde=
r applicable law. If you are not the intended recipient or the person r=
esponsible for delivering the message to the intended recipient, you ar=
e strictly prohibited from disclosing, distributing, copying, or in any=
 way using this message. If you have received this communication in err=
or, please notify the sender and destroy and delete any copies you may =
have received.


P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.

This e-mail (including any attachments) is confidential and may be lega=
lly privileged. If you are not an intended recipient or an authorized r=
epresentative of an intended recipient, you are prohibited from using, =
copying or distributing the information in this e-mail or its attachmen=
ts. If you have received this e-mail in error, please notify the sender=
 immediately by return e-mail and delete all copies of this message and=
 any attachments. Thank you.
