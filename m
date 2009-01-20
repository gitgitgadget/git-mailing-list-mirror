From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Newbie Query
Date: Tue, 20 Jan 2009 21:00:31 +0100
Message-ID: <49762D5F.2050702@dbservice.com>
References: <20090120191952.GA25322@uts.thewillards.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Chris Willard <chris@thewillards.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 20 21:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPNLG-0000AJ-W2
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbZATUfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 15:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755989AbZATUfd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:35:33 -0500
Received: from office.neopsis.com ([78.46.209.98]:48366 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbZATUfc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 15:35:32 -0500
X-Greylist: delayed 1994 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jan 2009 15:35:32 EST
Received: from [192.168.0.130] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Tue, 20 Jan 2009 21:02:14 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090117 Shredder/3.0b2pre
In-Reply-To: <20090120191952.GA25322@uts.thewillards.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106521>

On 01/20/2009 08:19 PM, Chris Willard wrote:
> Hello All,
>
> I am having a go at using git and need a bit of help.
>
> I have git installed on my laptop and on my pc. I created some files
> on the pc then used git close via ssh to put them on my laptop - all
> OK so far!
>
> I then modified the files, added them, commited the changes and then
> used git push to put them on the PC - still no problems.
>
> Both systems show the commits but the PC does not have the latest
> version of the files. Git status on the PC shows the file as changed
> but commiting give an error when pushing from the laptop.
>
> I assume that I need to run a command on the PC to get both systems
> the same. Is it a reset or something else?

http://git.or.cz/gitwiki/GitFaq#non-bare

tom
