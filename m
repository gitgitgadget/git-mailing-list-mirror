From: FernandoBasso <FernandoBasso.br@gmail.com>
Subject: Re: Really beginner on Version Control
Date: Tue, 21 Sep 2010 17:13:37 -0700 (PDT)
Message-ID: <1285114417273-5557145.post@n2.nabble.com>
References: <1285080133451-5555023.post@n2.nabble.com> <m3mxrak937.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 02:13:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyCxy-0005Ei-NO
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 02:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab0IVANi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 20:13:38 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48509 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab0IVANh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 20:13:37 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <FernandoBasso.br@gmail.com>)
	id 1OyCxt-0007K9-98
	for git@vger.kernel.org; Tue, 21 Sep 2010 17:13:37 -0700
In-Reply-To: <m3mxrak937.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156772>


I really appreciate your help. All of you. This is all starting to make sense
to me thanks to you guys.

Now, what are the possible ways that we can get to a conflict when merging
branches ? I'm doing some study tests, and some times I get conflicts, some
times I don't. I couldn't really understand what causes them or not yet. 

For instance, I have 'hello' in line 2 of site.php in the master branch. I
go to the  testing branch, edit site.php, change 'hello' for 'world' at the
same line, commit and got back to master. I merge testing into master and I
get no conflicts. Shouldn't it conflict ? (site.php in master also contains
the string 'world' in the place of 'hello' now).

-- 
View this message in context: http://git.661346.n2.nabble.com/Really-beginner-on-Version-Control-tp5555023p5557145.html
Sent from the git mailing list archive at Nabble.com.
