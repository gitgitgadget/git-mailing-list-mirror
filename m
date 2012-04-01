From: =?ISO-8859-1?Q?Andr=E9_Walker?= <andre@andrewalker.net>
Subject: GSoC mentors for Git.pm
Date: Sun, 01 Apr 2012 16:53:24 -0300
Message-ID: <4F78B234.3060901@andrewalker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 01 21:53:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEQqD-000258-OU
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 21:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab2DATx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Apr 2012 15:53:28 -0400
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:56516 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752559Ab2DATx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 15:53:27 -0400
Received: (qmail 1931 invoked by uid 0); 1 Apr 2012 19:53:27 -0000
Received: from unknown (HELO host245.hostmonster.com) (74.220.215.245)
  by oproxy8.bluehost.com with SMTP; 1 Apr 2012 19:53:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=andrewalker.net; s=default;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:From:Date:Message-ID; bh=SLiFUytR8E+yMSRxeu593am3ZjWupXDXbAckep+/ZPk=;
	b=mnnSdDn3LyIa0Ee38I9qgYBJmNqQ6pZj8Q0sFLw/aFrEh8n+L5o/yxbnu/fYduEFn6qiMJk2PBBAPCKH8TJHJ3kX+Jqqb4qT2bLojKSjoCs4bwZr7+LaOlRrxX2HlR76;
Received: from [187.104.134.84] (helo=[192.168.0.100])
	by host245.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <andre@andrewalker.net>)
	id 1SEQq7-0001c4-3a
	for git@vger.kernel.org; Sun, 01 Apr 2012 13:53:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
X-Identified-User: {2744:host245.hostmonster.com:picloadc:andrewalker.net} {sentby:smtp auth 187.104.134.84 authed with andre@andrewalker.net}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194483>

Hello,

I was considering applying for GSoC this year, but for personal reasons=
=20
I decided not to propose anything this year, and focus on some other=20
personal projects. Anyway, I was thinking about something that might=20
still help the Git organization this year, so I'd like to share the ide=
a=20
with you, to see if it's not too crazy, and if it would be doable.

In a previous mail, Jakub said one of the limitations for the number of=
=20
accepted students is the number of available mentors. Well, for the=20
project I'm interested in, modernizing Git.pm, he is the suggested=20
mentor himself, and also for the gitweb one (adding a JS framework). Bu=
t=20
if he is the only available mentor for both projects, and there are man=
y=20
students interested in both of them, only one will be accepted, as he'l=
l=20
probably be unable to mentor two students. Is that correct? So that=20
either "Javascript library in gitweb" is accepted, or "modernizing=20
Git.pm". (Of course, it seems one person can mentor two projects, but=20
that's not advised by Google, and Git would profit if there were at=20
least co-mentors for one of the projects.)

I was thinking... if the problem is the lack of mentors, would it be=20
possible, for instance, for the Git.pm proposal, to ask people from the=
=20
Perl community, like the ones who wrote Git modules on CPAN=20
(Git::Wrapper, Git::PurePerl, etc) to help out? Maybe they would have=20
different insights on what can be done in Git.pm, how it could be done=20
in a better way, etc. On the other hand, they would not make anything=20
the git community wouldn't approve, because the community would be=20
involved in every step. Do you think this is viable? Maybe there could=20
even be more than one mentor per student (last year I had two mentors=20
for GSoC), so that we could have one mentor who has a stronger knowledg=
e=20
in the Perl language, and another who has a stronger knowledge in Git's=
=20
internals, etc.

If this would be helpful, I'd be willing to contact people to see=20
whether they'd like to candidate for being a Git mentor. Also, I'm=20
suggesting the Perl community because I know some of them, and it makes=
=20
sense (at least in my head) for the project I was interested in. But=20
maybe this could be expanded to other proposals? If this was possible,=20
it could ease the burden for the current mentors, and get more projects=
=20
accepted for git.

Or maybe there are more people in this mailing list who would volunteer=
=20
for the job? I contacted =C6var Bjarmason to see if he is interested, b=
ut=20
maybe someone here would like too.

Regards,
Andr=E9
