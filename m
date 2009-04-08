From: layer <layer@known.net>
Subject: Re: need help with git show :1:...
Date: Wed, 08 Apr 2009 11:02:42 -0700
Message-ID: <7199.1239213762@relay.known.net>
References: <6838.1239212486@relay.known.net> <51419b2c0904081058p7d5a56c3j6aa5cebb0188ad43@mail.gmail.com>
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrc8I-00011B-M5
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbZDHSCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbZDHSCo
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:02:44 -0400
Received: from relay.known.net ([67.121.255.169]:49943 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751571AbZDHSCn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 14:02:43 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000034337; Wed, 8 Apr 2009 11:02:43 -0700
In-reply-to: <51419b2c0904081058p7d5a56c3j6aa5cebb0188ad43@mail.gmail.com>
Comments: In-reply-to Elijah Newren <newren@gmail.com>
   message dated "Wed, 08 Apr 2009 11:58:45 -0600."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116101>

Elijah Newren <newren@gmail.com> wrote:

>> Does the file have conflicts?  Try
>> git ls-files -s src/c/sock.c

Yes, it did have conflicts.  I resolved the conflicts via editing, but
want to look at the other versions before finalizing the edits.

quadra% git ls-files -s src/c/sock.c
100644 ef6c9b94c678dc79760edfd15a0796b3726b76f6 0	src/c/sock.c
quadra% 

Elijah, thanks for replying.
