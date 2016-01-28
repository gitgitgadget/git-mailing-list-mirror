From: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Subject: AW: [PATCH 2/2] stash: use "stash--helper"
Date: Thu, 28 Jan 2016 22:25:25 +0100
Message-ID: <BLU436-SMTP572EDBE67B8D37ECADD616A5DA0@phx.gbl>
References: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>	<0000015289f33e85-713596a1-2718-4c3a-bf3c-4a0f1048d401-000000@eu-west-1.amazonses.com> <CAGZ79kaPQP+-LpW8ExM2wmfftW4_oa7tB5XdfsdC8XHwH4aFOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Stefan Beller'" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:26:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOu5F-0006ZJ-Or
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 22:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967768AbcA1V00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 16:26:26 -0500
Received: from blu004-omc3s27.hotmail.com ([65.55.116.102]:65411 "EHLO
	BLU004-OMC3S27.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966022AbcA1V0Z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 16:26:25 -0500
Received: from BLU436-SMTP57 ([65.55.116.74]) by BLU004-OMC3S27.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Thu, 28 Jan 2016 13:26:24 -0800
X-TMN: [+q9fAHhp4qlvZeMCTwht4qvK3/qMo3Zl]
X-Originating-Email: [mha1993@live.de]
In-Reply-To: <CAGZ79kaPQP+-LpW8ExM2wmfftW4_oa7tB5XdfsdC8XHwH4aFOA@mail.gmail.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFSRr5uEh5S4K1KMC5oGcLx3KQ3HgJ3eYkQAY0LrtWf725V8A==
Content-Language: de
X-OriginalArrivalTime: 28 Jan 2016 21:26:22.0885 (UTC) FILETIME=[893D1D50:01D15A12]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285032>

> You had some good measurements in the coverletter, which is not going to be recorded in the projects history. This part however would be part of the commit.
> So you could move the speed improvements here (as well as the other reasoning) on why this is a good idea. :)

I considered that, but I thought it would inflate the size of the commit message quite a bit and represents a  pretty temporary information as I'm planning to port more code. Any further progression on this would make the old meassurements kind of obsolete IMHO. I decided to move it to the coverletter, because it is only valid information if you consider both commits. If the general opinion on here is that I should add it to the commit message though, I'll gladly update it.

>> https://github.com/git/git/pull/191
>
> Oh I see you're using the pull-request to email translator, cool! 

Yes, I did. It definitly makes things easier if you are not used to mailing lists, but it was also a bit of a kerfuffle. I tried to start working on coverletter support, but I couldn't get it to accept the amazon SES credentials I provided. I ended up manually submiting the coverletter. It also didn't like my name.

Thank you for your quick feedback. 
