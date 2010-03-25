From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Pseudonymous commits
Date: Thu, 25 Mar 2010 00:39:11 -0400
Message-ID: <4BA51E6B-7325-465A-B23E-7F3C5BF87700@mit.edu>
References: <4BAADF34.3080806@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 05:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nueqn-0004Og-A4
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 05:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab0CYEjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 00:39:15 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:45739 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082Ab0CYEjP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 00:39:15 -0400
X-AuditID: 12074424-b7b9dae000002832-83-4baae8f15d14
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id 14.C8.10290.1F8EAAB4; Thu, 25 Mar 2010 00:39:13 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o2P4dCmQ013519;
	Thu, 25 Mar 2010 00:39:12 -0400
Received: from [10.0.42.239] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o2P4dBbF000156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Mar 2010 00:39:12 -0400 (EDT)
In-Reply-To: <4BAADF34.3080806@gmail.com>
X-Mailer: Apple Mail (2.1077)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143148>


On Mar 24, 2010, at 11:57 PM, Mike.lifeguard wrote:
> 
> Git gives attribution by a "name" and an "email" - however several
> contributors I work with are uncomfortable giving that information. I
> can easily use a pseudonym (I do so for myself), but is there any way to
> not have an email? Or shall I just use "not@real.email"?

Most projects want some kind of way of communicator with their contributors; and some kind of accountability with their contributors.  Otherwise, how do you know whether said contributor isn't a Chinese intelligence agent trying to insert a backdoor into your program by submitting change using techniques demonstrated by the Underhanded C contest[1]?  :-)

[1] http://underhanded.xcott.com/

Of course, someone can easily claim any random name, and it's not hard to get a mail account; you could pick a random name like "Mike Lifeguard", and get a gmail account, for example.  :-)   On the Internet, no one knows whether you are a dog.  (Or a Chinese secret agent.  :-)

But if someone isn't willing to give even an e-mail address, I would think even the most lax project would probably want to think twice about whether to accept patches from this contributor....

-- Ted
