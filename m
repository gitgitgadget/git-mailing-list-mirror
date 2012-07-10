From: pbGit <pblakeley@gmail.com>
Subject: Re: Problems pushing???
Date: Mon, 9 Jul 2012 23:59:18 -0700 (PDT)
Message-ID: <1341903558821-7562762.post@n2.nabble.com>
References: <1341738766823-7562695.post@n2.nabble.com> <4FF97463.90002@ira.uka.de> <1341759063006-7562705.post@n2.nabble.com> <1341762216101-7562707.post@n2.nabble.com> <4FF9F999.9030808@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 08:59:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUPs-0001H3-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 08:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab2GJG7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 02:59:20 -0400
Received: from sam.nabble.com ([216.139.236.26]:33090 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998Ab2GJG7T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 02:59:19 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <pblakeley@gmail.com>)
	id 1SoUPm-00086E-Qn
	for git@vger.kernel.org; Mon, 09 Jul 2012 23:59:18 -0700
In-Reply-To: <4FF9F999.9030808@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201237>

Thanks for all your help.  Running through this a few more times and reading
the net I managed it ; )  I tested it cloning from the command line and all
seems good.

For developement I use eclipse with the eGit plugin.  When I try cloning it
putting all the relevant info in it fails.   I am sure this is due to the
ssh keys. I have set-up my keys accordingly.  Tried using the ssh agent but
with no success.  I can see the agent is running and tested that  and all
seems good with that. The error get is 

ssh://paul@localhost:22:
org.eclipse.jgit.transport.CredentialItem$StringType:Password:
ssh://paul@localhost:22:
org.eclipse.jgit.transport.CredentialItem$StringType:Password:

Hope you can help

--
View this message in context: http://git.661346.n2.nabble.com/Problems-pushing-tp7562695p7562762.html
Sent from the git mailing list archive at Nabble.com.
