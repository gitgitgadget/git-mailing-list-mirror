From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 05:11:15 -0800
Message-ID: <86iqqizgng.fsf@blue.stonehenge.com>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>
	<46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com>
	<20081120112708.GC22787@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>, git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:12:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39Kh-0007de-JI
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbYKTNLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbYKTNLQ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:11:16 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:5385 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbYKTNLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:11:15 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 135C21DE25F; Thu, 20 Nov 2008 05:11:15 -0800 (PST)
x-mayan-date: Long count = 12.19.15.15.8; tzolkin = 7 Lamat; haab = 11 Ceh
In-Reply-To: <20081120112708.GC22787@ravenclaw.codelibre.net> (Roger Leigh's message of "Thu, 20 Nov 2008 11:27:08 +0000")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101422>

>>>>> "Roger" == Roger Leigh <rleigh@codelibre.net> writes:

Roger> Except in this case I'm storing the content of *tarballs* (along with
Roger> pristine-tar).  I'm committing exactly what's in the tarball with
Roger> no changes (this is a requirement).  I can't change the source prior
Roger> to commit.

If you're not doing distributed source code development, why are you using
git?  It's hard to be angry at a screwdriver for not pounding in nails
properly.

Sounds like you want rsync or something.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
