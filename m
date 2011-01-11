From: sundarbun <sundarbun@yahoo.com>
Subject: Re: JGIT newbie question
Date: Tue, 11 Jan 2011 13:58:58 -0800 (PST)
Message-ID: <1294783138346-5912619.post@n2.nabble.com>
References: <1294771910028-5911913.post@n2.nabble.com> <AANLkTin=bZAgYeKHN2NUjYjZU5NBC_bs3bpCNNhijppq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 11 22:59:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcmF6-0000DL-Jx
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 22:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab1AKV7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 16:59:00 -0500
Received: from sam.nabble.com ([216.139.236.26]:50620 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755542Ab1AKV67 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 16:58:59 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <sundarbun@yahoo.com>)
	id 1PcmF0-0000to-BW
	for git@vger.kernel.org; Tue, 11 Jan 2011 13:58:58 -0800
In-Reply-To: <AANLkTin=bZAgYeKHN2NUjYjZU5NBC_bs3bpCNNhijppq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164996>


Thanks Shawn.. I did look at the jGit list and I will post there as well.

>>But if you want to avoid using the working directory
Not sure what this means.. perhaps I have to read up some more...

I got as far as what you have suggested with the Git object in the 
org.eclipse.jgit.api jar.

Where I got stumped was the specification of the userid/pwd/repo path
parameters that tells git when I init it (as I run on an aws machine with no
.git directory initially) to setup shop in a temp working directory that I
specify in the init. 

I was hoping to have an init command that I could pass a valid git repo url,
a user name and pwd and local fileDir so that a .git would be created and
then I can call checkout to get the part of the tree that I am interested
in.

If you have any insight.. I'd appreciate your comments.

thanks again.
S

-- 
View this message in context: http://git.661346.n2.nabble.com/JGIT-newbie-question-tp5911913p5912619.html
Sent from the git mailing list archive at Nabble.com.
