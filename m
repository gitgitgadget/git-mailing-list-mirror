From: "JD Guzman" <jd@jdguzman.com>
Subject: fatal: $HOME not set
Date: Thu, 11 Dec 2008 10:36:56 -0000
Message-ID: <003a01c95b7c$65b93a40$312baec0$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 11:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAj0z-000617-PA
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 11:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbYLKKmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 05:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbYLKKmK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 05:42:10 -0500
Received: from mout.perfora.net ([74.208.4.194]:63284 "EHLO mout.perfora.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754988AbYLKKmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 05:42:09 -0500
Received: from JDPC (host86-133-135-13.range86-133.btcentralplus.com [86.133.135.13])
	by mrelay.perfora.net (node=mrus0) with ESMTP (Nemesis)
	id 0MKp8S-1LAiuh3nnp-0002Ci; Thu, 11 Dec 2008 05:37:01 -0500
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AclbfGOh8HENGJfkSeOYtvnrZKBgTA==
Content-Language: en-us
X-Provags-ID: V01U2FsdGVkX18qsyc87MF69geU3qiKlprC54Ss+OKVw8DLg2L
 HJgA9528uI1hFtYKlz72TlKi7U4wtztWs9GEyilCesUtg3N9pl
 2ozLZQg0atJvKR3WtttIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102792>

This is probably a really stupid question but I'm trying to run git outside
of the shell provided by msysgit.
Everything works however when I try to set config options I get the error in
the subject line.  I would suspect this is because the windows command
prompt isn't providing any information about the user's home directory.  My
question is would this be something that I can set manually or does git rely
on the OS to provide this information?

Regards,

JD Guzman
