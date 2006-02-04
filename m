From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: Tracking and committing back to Subversion?
Date: Sat, 04 Feb 2006 11:51:08 -0800
Message-ID: <m2hd7e52dv.fsf@ziti.local>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz>
	<20060204054056.GB24314@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 04 20:51:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5TRC-00018a-73
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 20:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWBDTvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 14:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWBDTvJ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 14:51:09 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:33291 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964786AbWBDTvI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 14:51:08 -0500
Received: by wproxy.gmail.com with SMTP id 69so1022161wri
        for <git@vger.kernel.org>; Sat, 04 Feb 2006 11:51:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=huIS25Mp2TN07BeX/kKBQWu/e5GQXwQrUjU/aIYAKGBLmPL0UCK6gFD5h1iwaQZ1lZ0jXPbf7R68CfG0roZaE/o8IgGx5DmSi8bCj4bKmniIyVChHq9HcbCJ7Ndp2JVAdpBSxr3VnEqzJS8jslnC1A1QSRswmD1FVO3L7yDD3+Q=
Received: by 10.54.148.2 with SMTP id v2mr5090912wrd;
        Sat, 04 Feb 2006 11:51:07 -0800 (PST)
Received: from ziti.local ( [67.171.24.140])
        by mx.gmail.com with ESMTP id 33sm5509389wra.2006.02.04.11.51.06;
        Sat, 04 Feb 2006 11:51:06 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <20060204054056.GB24314@Muzzle> (Eric Wong's message of "Fri, 3 Feb 2006 21:40:57 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15599>

On  3 Feb 2006, normalperson@yhbt.net wrote:
>> Sam Vilain <sam@vilain.net> wrote:
>> Has anyone done any work on bidirectional access to SVN
>> repositories?  ie, tracking and committing.

I think tailor claims to be able to handle this:
http://www.darcs.net/DarcsWiki/Tailor

The README in the devel version seems to indicate that two-way sync
for svn <--> git is implemented (despite the table on the main page).  

--
 + seth
