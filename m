From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: git commit error on initial (the very first) commit
Date: Sun, 29 Jan 2006 20:26:54 +0300
Message-ID: <200601292026.54893.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 29 18:27:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3GKp-0001Ub-41
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 18:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWA2R1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 12:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWA2R1K
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 12:27:10 -0500
Received: from mx1.mail.ru ([194.67.23.121]:44677 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751088AbWA2R1J (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 12:27:09 -0500
Received: from [85.141.134.85] (port=47391 helo=cooker.home.net)
	by mx1.mail.ru with asmtp 
	id 1F3GKH-000GE8-00
	for git@vger.kernel.org; Sun, 29 Jan 2006 20:26:57 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15222>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

May be I do something wrong? What is correct procedure to initially import 
tree? git 1.1.4

{pts/0}% git init-db
defaulting to local storage area
{pts/0}% git add .
{pts/0}% git commit -m 'initial import'
usage: git-diff-index [-m] [--cached] [<common diff options>] <tree-ish> 
[<path>...]
common diff options:
... etc

Committing initial tree 4c9bc57b6911db86c7ab482cca33948a9ba20ef0

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD3PreR6LMutpd94wRAiP1AJwI93tNjyQ3PYjuwh/EP/GQJHhjKQCeNsuq
6oWKT+2XHaU3Qe50hkmkQ+g=
=493D
-----END PGP SIGNATURE-----
