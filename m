From: Kevin Sheedy <kevinsheedy@gmail.com>
Subject: Push to all repositories
Date: Wed, 8 Dec 2010 09:39:43 -0800 (PST)
Message-ID: <1291829983410-5816069.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 18:39:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQNzZ-0008PG-BF
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 18:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab0LHRjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 12:39:44 -0500
Received: from kuber.nabble.com ([216.139.236.158]:50035 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab0LHRjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 12:39:44 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <kevinsheedy@gmail.com>)
	id 1PQNzT-0007hP-DY
	for git@vger.kernel.org; Wed, 08 Dec 2010 09:39:43 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163207>


Will git let me push my changes to every member of the team?

I find a big problem with CVS & SVN is that I have to explicitly update my
code in order to keep in sync. This is a real pain-point as I often have to
do it several times a day and it can be very slow. We still regularly get
problems caused by developers being out of sync. Most people become
reluctant to do an update at all as they fear it will cause errors.

Clearcase has a great solution to this, "dynamic views". Whenever I check in
some code, the whole team magically get's my changes straight away.
Normally, they don't even notice, they're just forced to stay in sync. This
drastically reduces the number of 'code conflicts' where people make changes
to 'stale' files. This enforces the practise of "catching errors early". It
also keeps developers "honest" as they have to keep the quality of their
checkins high lest they get shouted at by the rest of the team.

Will git let a team stay in sync without everyone having to do manual
updates?
Basically, I want every developer to be able to push their code to the whole
team.
-- 
View this message in context: http://git.661346.n2.nabble.com/Push-to-all-repositories-tp5816069p5816069.html
Sent from the git mailing list archive at Nabble.com.
