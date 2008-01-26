From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Sat, 26 Jan 2008 00:10:21 +0000 (UTC)
Message-ID: <slrnfpkujd.all.joerg@alea.gnuu.de>
References: <1201198439-3516-1-git-send-email-pascal@obry.net>
 <4798D5E7.8070907@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 11:29:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIiHb-0005Bu-Mc
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 11:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbYAZK2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jan 2008 05:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbYAZK2Z
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 05:28:25 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:4217 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230AbYAZK2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 05:28:25 -0500
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 05902488025; Sat, 26 Jan 2008 11:28:22 +0100 (CET)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JIYcn-00019W-DL
	for git@vger.kernel.org; Sat, 26 Jan 2008 01:10:21 +0100
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1201306221 32517 192.168.0.5 (26 Jan 2008 00:10:21 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-77 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71772>

Hi Pascal,

Pascal Obry <pascal@obry.net> wrote:
> Typing too fast I've just made this mistake the third time today. It =
is=20
> of course easy to revert but a check seems appropriate here.

Why not use an alias?

% git config --get alias.cia
commit --amend

Bye, J=C3=B6rg.
--=20
Two types have compatible type if their types are the same.
[ANSI C, 6.2.7]
