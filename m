From: =?UTF-8?Q?Mika=C3=ABl?= <mikael.donini@gmail.com>
Subject: upgrading GIT from version 1.7.0.4 to 1.7.6.1.
Date: Mon, 19 Sep 2011 05:30:30 -0700 (PDT)
Message-ID: <1316435430491-6808156.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 14:30:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5czc-0005l3-Ej
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 14:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab1ISMab convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Sep 2011 08:30:31 -0400
Received: from sam.nabble.com ([216.139.236.26]:50071 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998Ab1ISMaa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2011 08:30:30 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <mikael.donini@gmail.com>)
	id 1R5czW-0002Wv-G5
	for git@vger.kernel.org; Mon, 19 Sep 2011 05:30:30 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181675>

Dear All,

I am working for a company where several hundreds of people are working=
 with
GIT ; in other words, GIT is a central tool for us since our working
processes are based on it.

Today, it is the time for us to upgrade from version 1.7.0.4 to 1.7.6.1=
 (the
latest stable).
It is important for us to work with the latest version since it correct=
s
defects that are very impacting for us.

The difficulty of this migration is that we can't afford migrations pro=
blems
(in order to maintain productivity and work).

That is the reason why I have a couple of questions:

1- Is it possible to have two GIT installations pointing on the same
repositories?=20

One of this installation would be GIT 1.7.6.1 used by a restricted numb=
er of
people (these people could be called 'beta-testers' of the new GIT vers=
ion).
The other installation would be GIT 1.7.0.4 used by the other users (th=
e
majority of users) with no impact on their productivity.

Once the beta-tests will be finished and successful, all the users will=
 move
to GIT 1.7.6.1.

2- Do you have any suggestions, trips, hints and best practices in orde=
r to
upgrade GIT in such a context?

Thanks a lot for your answers.

Best Regards,

Mika=C3=ABl Donini.

--
View this message in context: http://git.661346.n2.nabble.com/upgrading=
-GIT-from-version-1-7-0-4-to-1-7-6-1-tp6808156p6808156.html
Sent from the git mailing list archive at Nabble.com.
