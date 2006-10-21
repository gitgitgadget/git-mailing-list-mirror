From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 18:35:18 +0200
Message-ID: <845b6e870610210935y2a97398enf18e17c41f123907@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	 <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	 <vpqejt76vgz.fsf@ecrins.imag.fr>
	 <20061017073839.3728d1e7.seanlkml@sympatico.ca>
	 <20061021141328.GE29843@artax.karlin.mff.cuni.cz>
	 <BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE>
	 <845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com>
	 <BAYC1-PASMTP01706CD2FCBE923333A0CBAE020@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jan Hudec" <bulb@ucw.cz>, "Linus Torvalds" <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 18:35:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJoj-0002Qj-Lw
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 18:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbWJUQfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 12:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423357AbWJUQfW
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 12:35:22 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:59498 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422724AbWJUQfW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 12:35:22 -0400
Received: by py-out-1112.google.com with SMTP id z74so43800pyg
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 09:35:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y77qIAjuJePL1Bl2cN6IhM6qrVSYOgZhfmICWLmZFo8B32UgfQjpNoguqjEWGqjBXbFkE4QYzF95qnSF+fcHU2pXxeE/FJPSULPndfNDpLKlPx0DTkkSVySBGPDv/fGqCjLeAwTr/8bzsgHbVGeJdipbkrWY8+6AuTfkWfsR1lo=
Received: by 10.35.49.15 with SMTP id b15mr3001058pyk;
        Sat, 21 Oct 2006 09:35:18 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Sat, 21 Oct 2006 09:35:18 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP01706CD2FCBE923333A0CBAE020@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29633>

On 10/21/06, Sean <seanlkml@sympatico.ca> wrote:
> On Sat, 21 Oct 2006 18:19:54 +0200
> "Erik B=E5gfors" <zindar@gmail.com> wrote:
>
> > This is just plain wrong.
> >
> > bzr is a fully decentralized VCS. I've read this thread for quite s=
ome
> > time now and I really cannot understand why people come to this
> > conclusion.
> >
> > However, if you do want to work centralized, bzr has commands that
> > fits that workflow really good.
>
> Have you been reading this thread at all?

Yes.

> Even the bzr people have now
> stated rather firmly that the revno scheme doesn't work very well in
> a number of situations.  Numerous examples have been given where the
> revno will be useless, or worse misleading when bzr is used without
> a central server.  The answer from the bzr folks has been then don't
> use the revno in those situations.  However, it's quite clear from th=
e
> bzr UI that there is a _bias_ towards using revno's.
>
> So yes, clearly you can use bzr without a central server; but it's ju=
st
> as clearly biased against such usage.

So... I do agree that revnos might not fit perfectly in at all times.
But that they automatically mean that bzr is not a decentralized VCS,
I strongly disagree with.  They are just one part of the equation.

/Erik
--=20
google talk/jabber. zindar@gmail.com
SIP-phones: sip:erik_bagfors@gizmoproject.com
sip:17476714687@proxy01.sipphone.com
