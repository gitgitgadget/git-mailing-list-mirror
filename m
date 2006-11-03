X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 11:21:19 +0100
Message-ID: <20061103102119.GO20017@pasky.or.cz>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <20061103100142.GD16721@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 10:21:35 +0000 (UTC)
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061103100142.GD16721@diana.vm.bytemark.co.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30814>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfwAv-00082O-Lm for gcvg-git@gmane.org; Fri, 03 Nov
 2006 11:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752849AbWKCKVV convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 05:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbWKCKVV
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 05:21:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59874 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752849AbWKCKVU (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 05:21:20 -0500
Received: (qmail 28102 invoked by uid 2001); 3 Nov 2006 11:21:19 +0100
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Dear diary, on Fri, Nov 03, 2006 at 11:01:42AM CET, I got a letter
where Karl Hasselstr=F6m <kha@treskal.com> said that...
> On 2006-11-03 10:58:59 +0100, Karl Hasselstr=F6m wrote:
>=20
> > I believe all the mails I send with mutt are QP-encoded,
>=20
> I just checked, and that one certainly was.

Are you sure? As far as I can see, it's 8bit.

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
