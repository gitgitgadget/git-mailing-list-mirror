From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Future suggestion's to assist with changes to git.
Date: Thu, 28 Aug 2008 17:10:53 -0600
Message-ID: <alpine.LNX.1.10.0808281646570.18129@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqem-0006dA-8V
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbYH1XKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbYH1XKz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:10:55 -0400
Received: from suse104.zenez.com ([198.60.105.164]:18309 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbYH1XKy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:10:54 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 6E29EA7C8DD; Thu, 28 Aug 2008 17:10:53 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 5DD44A7C89D
	for <git@vger.kernel.org>; Thu, 28 Aug 2008 17:10:53 -0600 (MDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94201>

I would like to have a positive outcome of all the theaded emails.  So 
this is an attempt to create a new thread that may focus on what can be 
done in the future.

>From other threads, this was very note-able and I think it is a good 
start for this new thread...

On Thu, 28 Aug 2008, Jeff King wrote:
> On Thu, Aug 28, 2008 at 01:23:50PM -0700, Perry Wagle wrote:
>> But, my problem is not git<DASH> vs git<SPACE>, but the slap-dash way 
>> upward compatibility was broken and the "water over the dam" slippery 
>> slope rationalizations that refuse to consider reverting.  "You" will 
>> do it again in the future since you are declaring success here.  And 
>> "you" have likely done it in the past 6 months.
>
> I don't think Junio is declaring success. In fact, I think he has sent
> several messages saying (paraphrasing of course):
>
>  - this was obviously not done in the best manner possible, because of
>    the number of people complaining
>
>  - we will try to do better about notification next time such a change
>    is made. Please make suggestions about how to do so.
>
>  - since we have already released and already broken everybody, and
>    these people are now complaining on the list, there is not much
>    point in trying to notify people of _this_ change now

Maybe on item could be on the git web site news items could be created to 
announce backward compatibility changes.  I think most people do visit the 
main website to look for information.  Having these changes posted there 
or linked from the main page could be a positive method so something like 
this will not happen in the future.

> Junio (and others) have tried to be very careful about breaking
> backwards compatibility, especially for scripting interfaces. We thought
> sufficient steps were taken this time, but clearly some disagree.

+1, I am very grateful for the effort of all that try to keep this and the 
positive things done with git.  I really appreaciate what Junio does to 
notify every one on the email list.  What we learned is not everyone reads 
the changes being made with the announcements.  So maybe making a visible 
link or announcements on the main web page could assist with the 
notification and prevent future issues.

> So please stop making specious claims that there are crazy 
> backwards-incompatibility bugs lurking throughout new versions of git. 
> If there are, then please find and name them. If not, then I think the 
> git community would welcome suggestions about how better to notify users 
> about the rare changes like this one.
>
>
> -Peff

+1  So let's make constructive suggestions so we can prevent this in the 
future.

BTW, I dropped all the CC's to make sure this starts fresh.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
