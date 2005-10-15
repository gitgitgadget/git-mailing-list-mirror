From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: 15 Oct 2005 15:04:23 -0700
Message-ID: <86irvyigig.fsf@blue.stonehenge.com>
References: <867jciz18w.fsf@blue.stonehenge.com>
	<864q7kqsa4.fsf@blue.stonehenge.com>
	<7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net>
	<86achcoyvz.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0510141543030.23242@iabervon.org>
	<863bn3lypn.fsf@blue.stonehenge.com>
	<20051015215754.GD5509@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 00:04:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQu8q-0002LX-6U
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 00:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVJOWEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVJOWEd
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 18:04:33 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:9499 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751244AbVJOWEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 18:04:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id E00E48F778;
	Sat, 15 Oct 2005 15:04:23 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 09946-01-3; Sat, 15 Oct 2005 15:04:23 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 7A60B8F7CB; Sat, 15 Oct 2005 15:04:23 -0700 (PDT)
To: Nick Hengeveld <nickh@reactrix.com>
x-mayan-date: Long count = 12.19.12.12.16; tzolkin = 6 Cib; haab = 14 Yax
In-Reply-To: <20051015215754.GD5509@reactrix.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10149>

>>>>> "Nick" == Nick Hengeveld <nickh@reactrix.com> writes:

Nick> On Sat, Oct 15, 2005 at 06:03:00AM -0700, Randal L. Schwartz wrote:
>> OK, it happened this morning.  While syncing to update from
>> yesterday's version, I got:
>> ...
>> Definitely broken.  But I can "rsync" just fine.

Nick> Which version of curl did you build with?

curl 7.13.1 (powerpc-apple-darwin8.0) libcurl/7.13.1 OpenSSL/0.9.7g zlib/1.2.3

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
