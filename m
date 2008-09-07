From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: What's in git.git (Sep 2008, #01; Sat, 06)
Date: Sun, 7 Sep 2008 17:48:48 -0600
Message-ID: <alpine.LNX.1.10.0809071746260.25543@suse104.zenez.com>
References: <7vtzcso58c.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0809070812350.6003@suse104.zenez.com> <7v3akbopzb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0809071139060.6003@suse104.zenez.com> <7vd4jfn5hx.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0809071723090.25543@suse104.zenez.com> <7vljy3jzre.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:50:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcU10-00018G-M1
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbYIGXst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYIGXst
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:48:49 -0400
Received: from suse104.zenez.com ([198.60.105.164]:4128 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYIGXst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 19:48:49 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 2AD03A7C291; Sun,  7 Sep 2008 17:48:48 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 18D23A7C28E;
	Sun,  7 Sep 2008 17:48:48 -0600 (MDT)
In-Reply-To: <7vljy3jzre.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95196>

On Sun, 7 Sep 2008, Junio C Hamano wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>> On Sun, 7 Sep 2008, Junio C Hamano wrote:
>> ...
>>> I think we already have 6ffaecc (shell: do not play duplicated definition
>>> games to shrink the executable, 2008-08-19), which was cherry-picked from
>>> 4cfc24a (shell: do not play duplicated definition games to shrink the
>>> executable, 2008-08-19) on 'master'.  Do you still have problem building
>>> 'maint' on your boxes?
>>
>> No, maint does build.  I just thought your were going to release
>> 1.6.0.2 from master.  I think the next commit for set-linebug-setvbug
>> needs to be in it for release.
>
> Thanks for clarifying, so as far as you are concerned, 'maint', which is
> the only thing that matters for 1.6.0.2, is in a good shape ;-)

Yes, I guess I miss-understood your maintainer notes.  I re-read them 
before posting.  I thought I read that you branch off master for the point 
releases.  I guess that master would be only for 1.6.1 not 1.6.0.2.  Sorry 
for my miss-understanding.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
