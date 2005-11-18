From: John Benes <smartcat99s@gmail.com>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 22:35:35 -0600
Message-ID: <437D5A17.6050806@gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>	<b0943d9e0511160311k725526d8v@mail.gmail.com>	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>	<7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com>	<7vfypur5jb.fsf@assigned-by-dhcp.cox.net> <437D5219.6060300@gmail.com> <7v7jb6r35s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 05:41:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecxyd-0001p1-Ua
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 05:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVKREfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 23:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVKREfx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 23:35:53 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:1678 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932502AbVKREfw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 23:35:52 -0500
Received: by zproxy.gmail.com with SMTP id 13so106071nzn
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:35:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=VHZ/AUFmqu3rxOvlIhm+alJrBPLu/oCuecxXqMG4fxA/mVVmbrLgYZ5/c1jPCIZMArdL7Pv5mn/4RGtsGtF/sYtGwjlhexrRMiSlVQagARnhe2h4foDOGAzTPIXt8GhhQYizkle4aURs3HWNM6crVzoOARDxh3r9XLpgg6ETxbI=
Received: by 10.36.80.10 with SMTP id d10mr1907459nzb;
        Thu, 17 Nov 2005 20:35:51 -0800 (PST)
Received: from ?192.168.0.198? ( [68.96.128.241])
        by mx.gmail.com with ESMTP id c12sm12524nzc.2005.11.17.20.35.49;
        Thu, 17 Nov 2005 20:35:51 -0800 (PST)
User-Agent: Thunderbird 1.5 (Windows/20051117)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v7jb6r35s.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12195>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> Thanks.  This is the same problem as what Large Angly SCM
> reports.  What does your "diff --version" say?

Twinkie@squirrel ~
$ diff --version
diff (GNU diffutils) 2.8.7
Written by Paul Eggert, Mike Haertel, David Hayes,
Richard Stallman, and Len Tower.
[snip 2004 copyright notice]

Extra useful info about my cygwin enviroment:

Twinkie@squirrel ~
$ cygcheck -V
cygcheck version 1.74
System Checker for Cygwin
Copyright 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005 Red Hat, Inc.
Compiled on Jul  2 2005

cygwin1.dll Version: 1.5.18

HTH!

- --
John Benes
GPG Fingerprint: D519 25DB BB5C 38FC 9D02  02E7 596D BC50 F880 27FA
"It is not only the living who are killed in war." - Isaac Asimov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBQ31aF2F0oWcU9kCNAQJrSRAAqDVQuCuF0PBn0ssGJA4sZ5fSa4S4hUju
yftaR9dDaWqpML4ieMcp5NXD1HEm6yzJbL9WhGuDQlpolo7ujbiI1sx7jP53Au+3
zm7iWojJVnRBirRAqsZpD2Ufriuzwnm6/rPJqe97RSkYIm29BcKsiSly67mFKEKJ
AL/MiAmH62h7HLOjSRR2o+3eGmvMlAesojoLdoTaCkic5l34WIfv4EzSSTSfwS+O
cn0K8MFqbuuApZTwECl5OdmAVbKGdC0PjgqgJQIEM39dWxKqqGrmSLvbs42AAEok
tOPTdB+4O2ECEIIYtjiqUAZ2ZDwVvxJwEyTEt60tzvbcfX0TwfXaO+JDxd9gmr8P
he/f05NT+IlqFrcXyXD8PVc+29ZBr7ocM1k+VIzqclGIjHMO6VjytEO3xppbtEDz
iAA5MFYsCM5fiJRndNYiH51WvVMjmmY1SO6LJtqGiwZhX3/couMy71JorXeqGgaW
Yjrkvs8q9AtvTG3Nq9BpmJCz0kXHbMmULchooaNtpDlPVVti9CA08vJ/9PssWRfD
MrkVkEijTpkw/lWClqW91aGWT9vlMeQSBVZf8Cr2Zg9DQNAFEE4LiVmlt10odZGw
cE4TlhaCk2Z2X1AeuDTimyN7hL6FMVweMsLgio1XNpk/NOCGkgvXDo7R76MfU8PS
dsT2ItOIm6w=
=o9sa
-----END PGP SIGNATURE-----
