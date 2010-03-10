From: Pascal Obry <pascal@obry.net>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 22:06:15 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B9809C7.6060304@obry.net>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302> <vpqtyso5nfl.fsf@bauges.imag.fr> <alpine.DEB.1.00.1003101741350.3006@intel-tinevez-2-302>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 10 22:06:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpT6T-0007V2-HD
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 22:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203Ab0CJVF7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 16:05:59 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:62198 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190Ab0CJVF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 16:05:58 -0500
Received: by bwz1 with SMTP id 1so5387014bwz.21
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 13:05:56 -0800 (PST)
Received: by 10.204.48.136 with SMTP id r8mr90216bkf.120.1268255156127;
        Wed, 10 Mar 2010 13:05:56 -0800 (PST)
Received: from [192.168.0.100] (AVelizy-154-1-52-28.w83-199.abo.wanadoo.fr [83.199.34.28])
        by mx.google.com with ESMTPS id a11sm29275160bkc.15.2010.03.10.13.05.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 13:05:54 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <alpine.DEB.1.00.1003101741350.3006@intel-tinevez-2-302>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141920>

Le 10/03/2010 17:44, Johannes Schindelin a =E9crit :
> I cannot say anything about the Cygwin version, as I haven't used it =
in=20
> ages.

I'm using Cygwin version since years now. I'm building Git daily from
master on Cygwin. No problem on my side with Git.

I have some issues with git-svn from time to time because some DLL are
not properly relocated. I need to call Cygwin "rebaseall". This is ofte=
n
the case after installing a new version of SVN (under Cygwin) and/or
Perl. But apart from that git-svn run like a charm on Cygwin too. I
would expect Git on Cygwin a bit slower than a native version, but Git
is so fast (and much faster than SVN) than it is just ok as-is.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
