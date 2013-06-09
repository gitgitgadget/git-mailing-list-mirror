From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4 03/45] build: trivial cleanup
Date: Sun, 9 Jun 2013 19:17:41 +0200
Message-ID: <20130609171741.GA2091@goldbirke>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljFU-0003XZ-8d
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180Ab3FIRRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:17:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:61060 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3FIRRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:17:43 -0400
Received: from localhost6.localdomain6 (f051160074.adsl.alicedsl.de [78.51.160.74])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MYa6I-1UqhKZ2sZm-00UpkY; Sun, 09 Jun 2013 19:17:41 +0200
Content-Disposition: inline
In-Reply-To: <1370796057-25312-4-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:VHSxGdI2Txv11O+cZB1n8j/FGH+kyaP0Yr78qvphXSQ
 Mm52G4HrZcO2ne17m14/wyBO7eQb981EhtxYA5NRDmP2u/TQ/0
 y9kgMqyOnzEnZeGJWxD7pRW2+lhF09/mISZUVwGZpjZVSU5n1h
 LWgkHJedRhiFCf9e+cEU4nfZD5hIq3Q3Rhml1nd8DyIzO51GVg
 +IZtGIl1TqAExuiri3oTjqqf1LwXtI0r01qQ76T3zLv5737n39
 tfPrICns5/tkrJeU2VJb0bVswMDyTkJ9a8w9Ie6H10IRaVOlXi
 DZ1bngrFGTf78yQ3HkTlYZaHnWxmVHFeuT89kMzlT3IHny3cYJ
 tzkvObgbIbIO4aPJaCOY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227032>

On Sun, Jun 09, 2013 at 11:40:15AM -0500, Felipe Contreras wrote:
> There's no need to list again the prerequisites.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Please write more shortlog-friendly subject lines describing what the
actual change is.

In this case for example: "build: substitute library prerequisites
using $^"
