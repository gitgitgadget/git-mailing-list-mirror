From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 17:35:13 -0800
Message-ID: <86sl0xfd4e.fsf@blue.stonehenge.com>
References: <478D79BD.7060006@talkingspider.com> <m3bq7lncak.fsf@roke.D-201>
	<20080117005954.GM18022@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Thu Jan 17 02:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJfX-00059m-7k
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYAQBfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYAQBfQ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:35:16 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:44170 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbYAQBfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:35:15 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D2B251DE251; Wed, 16 Jan 2008 17:35:13 -0800 (PST)
x-mayan-date: Long count = 12.19.14.17.19; tzolkin = 10 Cauac; haab = 7 Muan
In-Reply-To: <20080117005954.GM18022@lavos.net> (Brian Downing's message of "Wed, 16 Jan 2008 18:59:54 -0600")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70804>

>>>>> "Brian" == Brian Downing <bdowning@lavos.net> writes:

Brian> Yes, you could use rsync or some other tool, but Git already has the
Brian> tools available, so why not take advantage of them?

It's very likely that rsync will be faster/better/cheaper/more-flexible
than git.  "Yes, you could use git, but rsync already does the job
better, so why not take advantage of it?"  Back at ya.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
