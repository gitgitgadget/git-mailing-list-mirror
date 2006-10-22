From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 02:09:51 +0200
Message-ID: <845b6e870610211709p13821dfdv1abab7225b0ab3a9@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	 <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	 <vpqejt76vgz.fsf@ecrins.imag.fr>
	 <20061017073839.3728d1e7.seanlkml@sympatico.ca>
	 <20061021141328.GE29843@artax.karlin.mff.cuni.cz>
	 <BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE>
	 <845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com>
	 <Pine.LNX.4.64.0610211353070.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, "Jan Hudec" <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 02:10:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbQum-0005u6-3i
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 02:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWJVAKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 20:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWJVAKE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 20:10:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:23030 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750722AbWJVAKB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 20:10:01 -0400
Received: by py-out-1112.google.com with SMTP id z74so38737pyg
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 17:09:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pvwSWSgcFsKs5WhqMWmmG+tBqgTsrvglzeuhdRkhzzOfP94oUthGDglzxxfYMR16H2c17FS6/hE9PxFBjEZROiOOEyVKzfWKAXdXXLMNiOfAUhuDhWQti/hSd1GUjmmcySF+K7ZiInC84n2LXdYz7GT1CBIWjeaiF+25uNUEtfg=
Received: by 10.35.17.8 with SMTP id u8mr3641381pyi;
        Sat, 21 Oct 2006 17:09:52 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Sat, 21 Oct 2006 17:09:51 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610211353070.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29695>

On 10/21/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sat, 21 Oct 2006, Erik B=E5gfors wrote:
> >
> > bzr is a fully decentralized VCS. I've read this thread for quite s=
ome
> > time now and I really cannot understand why people come to this
> > conclusion.
>
> Even the bzr people agree, so what's not to understand?

The use of the word "decentralized".

When I think centralized, I think "all users must commit to a central
repo/branch".  In this sense bzr is 100% fully decentralized.  You are
free to commit to a none-central branch.

What I mean is that it's fully decentralized, but it may have a bias
to the usage of a central branch/repo.

/Erik
--=20
google talk/jabber. zindar@gmail.com
SIP-phones: sip:erik_bagfors@gizmoproject.com
sip:17476714687@proxy01.sipphone.com
