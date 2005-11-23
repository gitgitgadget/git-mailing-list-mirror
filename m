From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Perl version support (was Re: [PATCH] git-mv is not able to  handle  big directories)
Date: 23 Nov 2005 14:01:07 -0800
Message-ID: <86hda3korg.fsf@blue.stonehenge.com>
References: <200511231141.57683.lan@ac-sw.com>
	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
	<867jazre78.fsf@blue.stonehenge.com>
	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
	<20051123135604.GB16995@mythryan2.michonline.com>
	<86mzjvphhj.fsf_-_@blue.stonehenge.com> <4384E574.8060801@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 23:03:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef2fz-0000ma-3Q
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 23:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVKWWBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 17:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVKWWBL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 17:01:11 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:28989 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932536AbVKWWBJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 17:01:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id B549E8F7CB;
	Wed, 23 Nov 2005 14:01:08 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 26110-01-25; Wed, 23 Nov 2005 14:01:08 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 45B648F7CE; Wed, 23 Nov 2005 14:01:08 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
x-mayan-date: Long count = 12.19.12.14.15; tzolkin = 6 Men; haab = 13 Ceh
In-Reply-To: <4384E574.8060801@zytor.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12653>

>>>>> "H" == H Peter Anvin <hpa@zytor.com> writes:

H> There are a lot of Perl modules we use, so limiting it to 5.5 is
H> probably a showstopper.

Hmm.  I should look at that then.  Most Perl Modules are 5.5
compatible, unless they've been written by naive people recently. :)

H> I'm very surprised you say that 5.6 is more prevalent than 5.8.

For individual early adopters, 5.8 is nearly universal.  But a lot of
my corporate clients upgrade *very* slowly, and are on 5.6 for now.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
