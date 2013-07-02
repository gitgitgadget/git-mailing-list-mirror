From: alois.mahdal.1-ndmail@zxcvb.cz
Subject: Re: --follow is ignored when used with --reverse
Date: Tue, 02 Jul 2013 10:56:08 +0200
Message-ID: <8c83f60d8eb4b7aaf4686f065e49ac93@zxcvb.cz>
References: <20130524012324.295dec77@hugo.daonet.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtwTG-0004hN-OO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439Ab3GBJBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 05:01:55 -0400
Received: from 89-185-248-48.static.axfone.eu ([89.185.248.48]:35254 "EHLO
	azzgoat.static.masterinter.net" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932225Ab3GBJBy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jul 2013 05:01:54 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2013 05:01:54 EDT
Received: from azzgoat.static.masterinter.net (localhost [127.0.0.1])
	by azzgoat.static.masterinter.net (8.14.4/8.14.4/Debian-4) with ESMTP id r628u9Ab022994
	for <git@vger.kernel.org>; Tue, 2 Jul 2013 10:56:09 +0200
Received: (from www-data@localhost)
	by azzgoat.static.masterinter.net (8.14.4/8.14.4/Submit) id r628u8WB022993;
	Tue, 2 Jul 2013 10:56:08 +0200
X-Authentication-Warning: azzgoat.static.masterinter.net: www-data set sender to alois.mahdal.1-ndmail@zxcvb.cz using -f
X-PHP-Originating-Script: 0:main.inc
In-Reply-To: <20130524012324.295dec77@hugo.daonet.home>
X-Sender: alois.mahdal.1-ndmail@zxcvb.cz
User-Agent: Roundcube Webmail/0.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229380>

On 2013-05-24 01:23, Alois Mahdal wrote:
> [...]
>
> When I use `git log --follow file` all is OK, but once I add
> `--reverse` to it, it no longer follows the file beyond renames.
>
> This makes it hard to query for when the file was really added,
> which I was trying to achieve with
>
>     $ git -1 --reverse --follow several_times_renamed_file

I see that this list is **really** busy---my question got lost as
a needle in an ocean.. :-)  Immediately.

Maybe I should record an incident?

Could anyone point me in the right direction?  Just say the word! :)

aL.

-- 
Alois Mahdal
