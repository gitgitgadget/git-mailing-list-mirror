From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: Setting up a bug tracking system where users can file bug
 reports and feature requests for Git
Date: Mon, 16 Feb 2009 09:11:20 +0000 (UTC)
Message-ID: <slrngpibdp.gmk.heipei@minime.lan>
References: <loom.20090216T025046-863@post.gmane.org>
 <7vab8nf38a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 10:13:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYzXO-0004Ak-R9
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 10:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbZBPJLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 04:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZBPJLg
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 04:11:36 -0500
Received: from main.gmane.org ([80.91.229.2]:60815 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbZBPJLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 04:11:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LYzVk-00043Z-3i
	for git@vger.kernel.org; Mon, 16 Feb 2009 09:11:32 +0000
Received: from 46-189.eduroam.rwth-aachen.de ([134.61.46.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 09:11:32 +0000
Received: from heipei by 46-189.eduroam.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 09:11:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 46-189.eduroam.rwth-aachen.de
User-Agent: slrn/pre0.9.9-111 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110151>

On 2009-02-16, Junio C Hamano <gitster@pobox.com> wrote:
> A tracking system is just a tool.  You need to have a competent and stable
> project secretary whose job is to look after the issues database.  The
> tasks involved are to expire the stale ones, to reject invalid entries, to
> prod the bug reporter for additional information, to find a volunteer to
> take up on an individual issue, to prod the bug reporter for confirmation
> on the fix once it is ready, and to close completed issues.

As I've been against web-based bug-trackers before I'd like to present 
an idea which, imho, is a good compromise. I'm afraid that the number of 
false bug-reports will increase dramatically with the introduction of 
such a bug-tracker, eating up time of the volunteers. Also, as I 
mentioned, I really dislike using web-based tools.

If we had such a secretary who's not only familiar with the bugtracker 
but also familiar enough with git and it's development organization, 
he/she could work with the system, filter out the noise and mail real 
bugs or well-thought-through feature-requests to this mailing-list (with 
a link back to the bugtracker) with the full text of the bug and maybe 
his/her oppinion about it.

But maybe that's just duplication of work, in your eyes.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
