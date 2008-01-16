From: Mike Krier <mikek@onehammer.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 01:07:18 -0500
Message-ID: <478D9F16.2000801@onehammer.com>
References: <478D79BD.7060006@talkingspider.com> <478D8062.3090506@gmail.com> <478D9D60.9070807@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 07:14:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF1Xl-0006AZ-87
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 07:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbYAPGOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 01:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbYAPGOD
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 01:14:03 -0500
Received: from relay02.pair.com ([209.68.5.16]:2065 "HELO relay02.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751646AbYAPGOB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 01:14:01 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2008 01:14:00 EST
Received: (qmail 68465 invoked from network); 16 Jan 2008 06:07:20 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 16 Jan 2008 06:07:20 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <478D9D60.9070807@talkingspider.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70638>



Mike wrote:
> 
> No, good idea. But it didn't work.  When I git commit -a, I get "fatal: 
> Not a git repository"
> 
> (And also even if that worked, it wouldn't work on an NTFS partiton, 
> right...)

Wait, it worked!  thanks!

Hmm although some of our code is (necessarily) on an NTFS partition... hmm..
