From: =?utf-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Subject: AW: [PATCH 2/2] stash: use "stash--helper"
Date: Fri, 29 Jan 2016 20:37:26 +0100
Message-ID: <BLU436-SMTP17832CE801BA2CA0636A82FA5DB0@phx.gbl>
References: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>	<0000015289f33e85-713596a1-2718-4c3a-bf3c-4a0f1048d401-000000@eu-west-1.amazonses.com>	<CAGZ79kaPQP+-LpW8ExM2wmfftW4_oa7tB5XdfsdC8XHwH4aFOA@mail.gmail.com>	<BLU436-SMTP572EDBE67B8D37ECADD616A5DA0@phx.gbl>	<CAGZ79kYVRY+6zFnHe8LPp2E_W_gAs--Vog-HoqXW-Do_WgHGXw@mail.gmail.com> <CAFY1edZGvdmESLdax1ErTdgyj+A7B+K9zKHsmF0Qb6d_XEk_mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Roberto Tyley'" <roberto.tyley@gmail.com>,
	"'Stefan Beller'" <sbeller@google.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 20:37:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPErQ-0007gD-CU
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 20:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbcA2Thc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 14:37:32 -0500
Received: from blu004-omc3s33.hotmail.com ([65.55.116.108]:55715 "EHLO
	BLU004-OMC3S33.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348AbcA2Thb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 14:37:31 -0500
Received: from BLU436-SMTP178 ([65.55.116.72]) by BLU004-OMC3S33.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Fri, 29 Jan 2016 11:37:31 -0800
X-TMN: [XGBbL1ODvhh1x7ucF/Y2iKu7ZCzB49x+]
X-Originating-Email: [mha1993@live.de]
In-Reply-To: <CAFY1edZGvdmESLdax1ErTdgyj+A7B+K9zKHsmF0Qb6d_XEk_mA@mail.gmail.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFSRr5uEh5S4K1KMC5oGcLx3KQ3HgJ3eYkQAY0LrtUCR9tD7QEbopkTAyTFoMWfvKRCMA==
Content-Language: de
X-OriginalArrivalTime: 29 Jan 2016 19:37:29.0695 (UTC) FILETIME=[7D912EF0:01D15ACC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285090>

>>> Yes, I did. It definitly makes things easier if you are not used to mailing lists, but it was also a bit of a kerfuffle. I tried to start working on coverletter support, but I couldn't get it to accept the amazon SES credentials I provided. I ended up manually submiting the coverletter. It also didn't like my name.

> Apologies for that - https://github.com/rtyley/submitgit/pull/26 has just been deployed, which should resolve the encoding for non-US ASCII characters - if you feel like submitting another patch, and want to put the eszett back into your GitHub account display name, I'd be interested to know how that goes.

You don't need to apologise. I knew the tool was WIP and had seen the Isuue before Iattempted to submit this. I will try out the patched version when I submit v2 of this.
