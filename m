From: David Campbell <dcamp2@ddcamp.nl.tn>
Subject: -//i'MSG
Date: Wed, 23 Mar 2016 09:50:23 +0100
Message-ID: <DB4PR02MB30301C992A857C9A24EAECBB4810@DB4PR02MB303.eurprd02.prod.outlook.com>
Reply-To: <david.campbell341@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Recipients <dcamp2@ddcamp.nl.tn>
X-From: git-owner@vger.kernel.org Wed Mar 23 10:07:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiekp-00075G-8o
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 10:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbcCWJG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 05:06:58 -0400
Received: from mail-db3hn0254.outbound.protection.outlook.com ([157.55.234.254]:29344
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753823AbcCWJG4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 05:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ddcamp.onmicrosoft.com; s=selector1-ddcamp-onmicrosoft-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zgnNwHkb1KTG2ofbdIhAuOFv2Cp89DJCM9ekkv4Lv8Y=;
 b=hZiuAEWQljw8oB2MHzyOHE9yYV1BO2xdOV6yFZv7NUsv7PvN1nrQ5MrdNs1zWCe5tabfRcPR0YSQA6q72l3WtvXON+yItp+RG5R9b3wT3sNfbnHJXCM3xuQ3fDqAxnbhdcfG9DeAmMMZOSg1ROJBH5+VzEwG0AtG7Iio85+oJ+4=
Authentication-Results: tiscalinet.it; dkim=none (message not signed)
 header.d=none;tiscalinet.it; dmarc=none action=none header.from=ddcamp.nl.tn;
Received: from [10.9.253.218] (23.105.140.107) by
 DB4PR02MB303.eurprd02.prod.outlook.com (10.242.194.18) with Microsoft SMTP
 Server (TLS) id 15.1.434.16; Wed, 23 Mar 2016 08:51:12 +0000
Content-Description: Mail message body
X-Antivirus: avast! (VPS 160322-1, 03/22/2016), Outbound message
X-Antivirus-Status: Clean
X-Originating-IP: [23.105.140.107]
X-ClientProxiedBy: BLUPR07CA0107.namprd07.prod.outlook.com (10.255.223.178) To
 DB4PR02MB303.eurprd02.prod.outlook.com (10.242.194.18)
X-MS-Office365-Filtering-Correlation-Id: 310cf100-64ce-4e7e-ab38-08d352f85f58
X-Microsoft-Exchange-Diagnostics: 1;DB4PR02MB303;2:VvfN5BP1myiljxRBwXxYZ5mqdNMBHO0F+B54JEpiEG3zjL1YwQT6IwW/BofIpmU4DhA2A7Zvjj/1hgs8L4TggKHR9o3Z6n7BuY81N2dskB/UftcJPw8/0sYecXwfCmjCkfWdGQGd53EDc2H5A/4CVHpgluD86ZOrEyesM4fuq4LZWeJL0IkBX9iezJwHCnGm;3:5PBK/m4wnhic2gjAKArJxKj26+9KGMNo2gHOa1UEEnjypP3+Ex8moZg1ihWUOB0EPAiZeD/7Fen/FIcGj9zvzH5pvocNTY+y1r7bGkfQ+1g/ZvYXWJo1o75wr6qPEc+x
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DB4PR02MB303;
X-Microsoft-Exchange-Diagnostics: 1;DB4PR02MB303;25:sywxeSH1Bl9VDj5d6p7LI6mu49k6XR2cp8tnCxdZauOgSI4g1So1aIQhmKpUwl1Paem4PmflMlP8wX8xeVUbQH22D+ju1jledMc1gjh58HlBlA+ZPQ2F662BXid7WtBPmKCqMTsDMw5105iq+b7Hrr+cBr1cF85SGv0MMqWEMUsXJTt7SIl/6nSULiB2di9vYMgFSSfROw6SmOXYlfsfhayo2Cs7+Tg2n6aHxgMV05oWGXRr5fvunOX8/tcI03EU+TbzOtrWGJXsIXlDZpJ7D9ZOAyPk+OAlH5nHgtdtKx1sPoulo1f8lkzCo+mAeCNNk3ov1gH3BHYX5DQyQ9wgZ6sSIVBVS/v7gzQuOJEoaIaIJJ6N9kVyI+UWuoFSxuyTre0A/QIG9UaCMmV9XxouICxguduKE7TS8ijeqC/+HNsw69V1ZCsHArFARx+Ny5s1Dwz+MQa5L2sTCZ5E2AcQ0lKoF3aC/jlie4L+jzO3Rx4trbLf26l3NfbCp6IRo7+bqyKXp9m/62SZ8I0fkRVgaRIR6fwjCKWWgtptho+dpwP8iZYnnEbbg0j19jtAcSaZkNvh4jPQLr+JvuEt90lc+feqJugPDPDlJe5SKL7yTbhcZMstwYyoVoS6hH5yuyHncft8KhQB6RoO55NoP+7/uCDewWdrgLUUHGsXvJDwybg=
X-Microsoft-Antispam-PRVS: <DB4PR02MB303B443BF196F247BC29E87B4810@DB4PR02MB303.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040046)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041046)(6043046);SRVR:DB4PR02MB303;BCL:0;PCL:0;RULEID:;SRVR:DB4PR02MB303;
X-Microsoft-Exchange-Diagnostics: 1;DB4PR02MB303;4:vWiaWxqrDHU8dajbN7kb1ZS/c60nXYpfD7iTRtLpQCSPnpt+GdEfWMEoPZbcYlUkn5eSCwfAPfj4uDPB4fAroAk8HH1ltxXLCEedlDJEc0MjOSjJNhwdDP5OA42YZa7dojDxT2vowvtvsJzTLT3h+u6+86b/QE/2lLdnJZNVhqWDMBbat3laxQdIy2D52dwCSKNj0kB3bkBCS5UZuqKd7DSItMG6zEgQQoFPxn2Y8+MEIbnuS/KqSnlmEZ5gE/S50Q6MzVA2yhp04g5AgKslK+xelruhIe1pAuY9cF6rBhjLwRcpqigiv+AYfn5tHbIM0Ux2LIwsdwOWblCdtQDc6vGxSZUT9jpY8SH60KaI5FLFG4TA8dFXP19V9GD54+/dPJRiOzo6Za8gCRvBffOgv/5hVwgl9EwaL1UhcppOHCg=
X-Forefront-PRVS: 08902E536D
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10009020)(4630300001)(6009001)(6049001)(2906002)(250100001)(42186005)(33656002)(50466002)(551934003)(74316001)(2860700001)(6200100001)(229853001)(4001450100002)(76576001)(1096002)(66066001)(107886002)(77096005)(110136002)(15975445007)(5004730100002)(50986999)(54356999)(53806999)(23756003)(74482002)(189998001)(5008740100001)(43066003)(3846002)(19580395003)(81166005)(47776003)(53256004)(6116002)(86362001)(586003)(216984002);DIR:OUT;SFP:1501;SCL:9;SRVR:DB4PR02MB303;H:[10.9.253.218];FPR:;SPF:None;MLV:ovrspm;PTR:InfoNoRecords;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DB4PR02MB303;23:sTBvIcbu3NG/2w2fZcdSk+oSZoW6jsr9YnhgCfdh?=
 =?iso-8859-1?Q?5xtZ1Aro9m8zTf10PdyDzwBt/oEEPAOCoS8MUv/Gmch80lBnWbYrbdWeDl?=
 =?iso-8859-1?Q?ABTY0KX7a+QyKFImPFt9P4D7yDcjPy5auUBrkZocPywQOc2AfmhK19y8vm?=
 =?iso-8859-1?Q?V96JGENyIdPkZJVC9ox7hOHRrxskPdh8igGRR+s+hIX5nlBp2GNCT0ZNtk?=
 =?iso-8859-1?Q?0loRHcLj05hQBxt00nBmcDIxK2QQw2FtG95sYBFPVRrmTsELCdKvpNefWI?=
 =?iso-8859-1?Q?myT+4fAYGxX37WqSdfDAYluEOBP3XA/sER871+HTzGQZP7A/jIl8C109L0?=
 =?iso-8859-1?Q?SzVn8KGn2mneH/fKdcXKueXXYD+07A6e3b8c3xWc/+REV8Kq+qOgKgfbaI?=
 =?iso-8859-1?Q?7KNLHvM+/VrDRNa/yqETTti2CTjQ1T8sfpJZhGaeGv0fQaHCx9fMrRPJS6?=
 =?iso-8859-1?Q?D2N9nAJhJgHB6qAGB7uFa/CLYD4SjquH3hsm+5Oy7Vol5vvkOKi2a/aSPi?=
 =?iso-8859-1?Q?rB7mlbkV8WiOJm9JNB4UxhZyPEs/t3R8dn6jJmjotlIjyU7Aaulf2isqPj?=
 =?iso-8859-1?Q?aQf2zDxX4SiKvdWTqaJouT3VRZTgnh9uxEsYf25uClg16owPfs0gSxK5nc?=
 =?iso-8859-1?Q?JeA2 
X-Microsoft-Exchange-Diagnostics: 1;DB4PR02MB303;5:QRptrEBJdfu9kRJ1QaBQGVl0cbC8CDbk0yQbZzDr91UAeGq6D7NQnDSj45gbk7qKQ8ZdMubBp6dFTEhRGME5LC8BRRzlJo4HQ62JUHiV7KXtwp9RUAgNMqRzmYjpeOAe5franMvvtWm0Y6USIAYbNg==;24:0hONAUJV/SpXbmaRdaIQKaeMvozMkEqGba1P4Sd2bUpKPgLKKtMCcFwrS1TLnfsuT+w23JjRjkBQB8VhvZt4+A==
SpamDiagnosticOutput: 1:22
SpamDiagnosticMetadata: 00000000%2D0000%2D0000%2D0000%2D000000000000
X-OriginatorOrg: ddcamp.nl.tn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2016 08:51:12.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB303
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289608>

Dear friend,

I am Mr. David Campbell, a staff of a bank in United Kingdom. One of our accounts, with holding balance has been dormant and last operated many years ago. Nobody has done anything as regards the claiming of this money. This is because the account owner has no family member or friends that are traceable. I have tried to locate the relations but without success and that is why I decided to find a reliable partner to move the money with.

My proposition to you is to seek your consent to present you as the Next of kin and beneficiary of this late client, So that the proceeds of this account shall be paid to you, and then we can share the amount on a mutually agreed percentage.

This transaction is totally free of risk and troubles as the fund is legitimate and does not originate from drug, money laundry, terrorism or any other illegal act. The funds will be released to you after necessary processes have been followed.

I anticipate your cooperation and utmost confidence. Awaiting your reply stating your willingness.

Regards

David Campbell

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
