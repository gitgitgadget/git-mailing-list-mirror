From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: Draft v1.5.0 release notes
Date: Tue, 02 Jan 2007 08:22:33 +0100
Message-ID: <87vejp7v0m.fsf@morpheus.local>
References: <7vlkkm47eg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 02 09:18:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1erI-0007B5-BO
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 09:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbXABISx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 2 Jan 2007 03:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932973AbXABISx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 03:18:53 -0500
Received: from main.gmane.org ([80.91.229.2]:35878 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932964AbXABISw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 03:18:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H1er4-0005xg-JS
	for git@vger.kernel.org; Tue, 02 Jan 2007 09:18:42 +0100
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 09:18:42 +0100
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 09:18:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:m7ewHOR3GL0JpufRoIRdfcWw5hE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35779>

Junio C Hamano <junkio@cox.net> writes:

> * Foreign SCM interfaces
>=20
>   - git-svn now requires the Perl SVN:: libraries, the
>     command-line backend was too slow and limited.
>=20
>   - the 'commit' command has been renamed to 'set-tree', and
>     'dcommit' is the recommended replacement for day-to-day
>     work.

The second item in this list is misleading.  It states that the
"comit" subcommand has been renamed.  But I don't believe it's the
"commit" subcommand of the "git" command.  So what is it a subcommand
to?

--=20
David K=C3=A5gedal
