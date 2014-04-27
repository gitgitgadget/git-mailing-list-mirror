From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Sun, 27 Apr 2014 23:12:59 +0100
Message-ID: <535D80EB.2090701@game-point.net>
References: <535C47BF.2070805@game-point.net> <1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com> <535D3DF8.4020904@game-point.net> <53a594dd-cd3d-4b33-ada8-3d7e08b86ee2@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 00:13:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeXJl-0004JI-GG
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 00:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbaD0WM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 18:12:56 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:58614 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbaD0WMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 18:12:55 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id E92E418A09AC;
	Sun, 27 Apr 2014 17:20:44 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <53a594dd-cd3d-4b33-ada8-3d7e08b86ee2@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247229>

On 27/04/2014 22:40, James Denholm wrote:
>> Also, you don't always have something you can link a commit to in an
>> issue tracker.  You may just be implementing a feature that has been
>> agreed upon, independently of any such tracker.  In that case, there's
>> no bug# to link to.
>
> In which case, refer to whatever system you use. If you aren't
> using a ticketing system, have the line "Relates-to: Water
> cooler conversation with Bob on July 28th" or whatever the
> patches relate to.
>
> (Arguably, though, the better solution is to use a ticketing
> system, or anything that allows discussion to be easily
> referenced.)

Well, as I said elsewhere in this discussion, Git should provide that 
functionality built-in, IMHO.  It would be good to be able to set a 
one-liner in my .gitconfig to tag each commit with a "branch checked 
into" trailer.

-- 
Best regards,
Jeremy Morton (Jez)
