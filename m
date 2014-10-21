From: RaviKiranGoud_Palpanoori@vfc.com
Subject: RE: Git Help needed
Date: Tue, 21 Oct 2014 12:31:55 +0000
Message-ID: <5f722e496fea4a96beb36764d5822d02@DM2PR0801MB0896.namprd08.prod.outlook.com>
References: <898fcfcd0c4f41da805abdd41622058f@DM2PR08MB477.namprd08.prod.outlook.com>
 <20140801200459.GA53075@vauxhall.crustytoothpaste.net>
 <6a7fe740d5bd4e4fb3a3f6d8a81b4c26@DM2PR08MB477.namprd08.prod.outlook.com>
 <20140801205939.GA57436@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, R_Frank_Lewis@vfc.com
To: sandals@crustytoothpaste.net
X-From: git-owner@vger.kernel.org Tue Oct 21 14:55:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgYxn-0004ng-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 14:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbaJUMyz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2014 08:54:55 -0400
Received: from itxf2aln14.vfc.com ([167.64.248.24]:2589 "EHLO
	ITXF2ALN14.VFC.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbaJUMyy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2014 08:54:54 -0400
X-Greylist: delayed 998 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Oct 2014 08:54:54 EDT
Received: from na01-bn1-obe.outbound.protection.outlook.com ([167.64.245.242])
          by itgc2abb1.vfc.com (Lotus Domino Release 8.5.3FP2 HF23)
          with ESMTP id 2014102108315834-121375 ;
          Tue, 21 Oct 2014 08:31:58 -0400 
Received: from DM2PR0801MB0896.namprd08.prod.outlook.com (25.160.131.156) by
 BY2PR08MB474.namprd08.prod.outlook.com (10.141.142.142) with Microsoft SMTP
 Server (TLS) id 15.1.6.9; Tue, 21 Oct 2014 12:31:55 +0000
Received: from DM2PR0801MB0896.namprd08.prod.outlook.com ([25.160.131.156]) by
 DM2PR0801MB0896.namprd08.prod.outlook.com ([25.160.131.156]) with mapi id
 15.00.1049.012; Tue, 21 Oct 2014 12:31:55 +0000
Thread-Topic: Git Help needed
Thread-Index: Ac+tvs0jfY/57SfCRUmWblNnsOxG7AABRMiAAACeFuAAAUqtgAAADpVQD9eh6UA=
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [167.64.57.10]
x-microsoft-antispam: BCL:0;PCL:0;RULEID:;SRVR:BY2PR08MB474;
x-exchange-antispam-report-test: UriScan:;
x-forefront-prvs: 0371762FE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(189002)(377454003)(51704005)(24454002)(13464003)(51874003)(164054003)(199003)(86362001)(64706001)(20776003)(101416001)(92566001)(76482002)(46102003)(40100003)(80022003)(108616004)(66066001)(97736003)(21056001)(99286002)(105586002)(77096002)(95666004)(19580405001)(19580395003)(107046002)(74316001)(4396001)(15975445006)(85306004)(31966008)(54356999)(122556002)(106356001)(87936001)(15202345003)(93886004)(85852003)(50986999)(2656002)(99396003)(76576001)(110136001)(33646002)(76176999)(120916001)(24736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR08MB474;H:DM2PR0801MB0896.namprd08.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-OriginatorOrg: vfc.com
X-MIMETrack: Itemize by SMTP Server on ITGC2ABB1/VFITS/VF Corporation(Release 8.5.3FP2
 HF23|July 24, 2012) at 10/21/2014 08:31:58 AM,
	Serialize by Router on ITXF2ALN14/InternetMail(Release 8.5.3|September 15, 2011) at
 10/21/2014 08:54:54 AM,
	Serialize complete at 10/21/2014 08:54:54 AM
X-TNEFEvaluated: 1
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,
My Open SSL vendor is IBM. In fact I am using AIX OS from IBM. When we =
(Myself and Frank. Frank is cc'ed in this email)  discussed with IBM te=
am, they asked some details on what flag settings need to be used to re=
compile, what parameter settings they need to do, etc.  IBM team told i=
t is easy to recompile if they have provided with the details.

Could you please help us to provide additional details for compilation.=
 Thanks in advance.

Regards,
Ravi.

-----Original Message-----
=46rom: Ravi=A0Kiran=A0Goud Palpanoori=20
Sent: Friday, August 01, 2014 5:03 PM
To: 'brian m. carlson'
Cc: git@vger.kernel.org
Subject: RE: Git Help needed

Hi Brian,
Thank you.
Understood OpeSSL and vendor from your original message now.

Thanks,
Ravi.

-----Original Message-----
=46rom: brian m. carlson [mailto:sandals@crustytoothpaste.net]
Sent: Friday, August 01, 2014 5:00 PM
To: Ravi=A0Kiran=A0Goud Palpanoori
Cc: git@vger.kernel.org
Subject: Re: Git Help needed

On Fri, Aug 01, 2014 at 08:27:24PM +0000, RaviKiranGoud_Palpanoori@vfc.=
com wrote:
> Hi brian,
> Thanks for your quick reply.
>=20
> I downloaded git 1.9.0 from the site
> https://code.google.com/p/git-core/downloads/list.

That URL is obsolete.  Try https://www.kernel.org/pub/software/scm/git/
Google Code no longer allows anyone to upload tarballs.

> Does it mean the package available at above location has built with=20
> specific version of OpenSSL. How can I find out which OpenSSL version=
=20
> is used in the packages available at the above location.

If you're downloading the source tarball and building it yourself, then=
 it's whatever version of OpenSSL is on your system.  To my knowledge, =
nobody provides pre-built packages of git for AIX.

> Could you please suggest the site from where I need to download git=20
> for AIX OS.

As I mentioned above, you'll probably need to build it yourself.

> Who are the vendors of git so that I will check how to proceed on thi=
s.

When I referred to having your vendor patch the check out, I meant your=
 vendor of OpenSSL.

--
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion onl=
y
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B18=
7
