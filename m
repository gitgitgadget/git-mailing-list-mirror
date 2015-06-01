From: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>
Subject: Getting the full path of a conflicting file within a custom merge
 driver?
Date: Mon, 1 Jun 2015 15:46:44 +0000
Message-ID: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:46:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzRvR-0007H1-4b
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbbFAPqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 11:46:48 -0400
Received: from mail2.dwpbank.de ([145.253.155.115]:38740 "EHLO
	mail2.dwpbank.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbFAPqr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 11:46:47 -0400
X-IronPort-AV: E=Sophos;i="5.13,533,1427752800"; 
   d="scan'208";a="786461"
Received: from DWPWHMS531.dwpbank.local ([169.254.2.243]) by
 DWPFRMS530.dwpbank.local ([169.254.3.86]) with mapi id 14.03.0195.001; Mon, 1
 Jun 2015 17:46:45 +0200
Thread-Topic: Getting the full path of a conflicting file within a custom
 merge driver?
Thread-Index: AdCcgiEmcewjfbrsSCO3jW4YkOAV1w==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.236.155]
x-c2processedorg: 25ee705c-9766-409d-8ffd-513701a730da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270427>

Hello,

I'm wondering if there is no option to find out the full path of a conf=
licting file from within a custom merge driver? If I understand this co=
rrectly, Git only provides the name of the 3 temporary local files and =
the size of the limiter. But is there any possibility to get the path o=
f the file via a Git command, that I can run from within the merge driv=
er? Maybe as part of the repository's status?

Thank you in advance.

Greetings,
Andreas Gondek
Applications
________________________________

Deutsche WertpapierService Bank AG
ITTAS
Derendorfer Allee 2
40476 D=FCsseldorf
Tel.: +49 69 5099 9503
=46ax: +49 69 5099 85 9503
E-Mail: Andreas.Gondek@dwpbank.de
http://www.dwpbank.de

Deutsche WertpapierService Bank AG | Wildunger Stra=DFe 14 | 60487 Fran=
kfurt am Main=20
Sitz der AG: Frankfurt am Main, HRB 56913 | USt.-ID: DE 813759005=20
Vorstand: Thomas Klanten, Dr. Christian Tonnesen
Aufsichtsrat: Wilfried Groos (Vors.)
