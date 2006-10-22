From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 02:13:22 +0200
Message-ID: <845b6e870610211713m413afd28tcdf24934df25d3f5@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	 <vpqejt76vgz.fsf@ecrins.imag.fr>
	 <20061017073839.3728d1e7.seanlkml@sympatico.ca>
	 <20061021141328.GE29843@artax.karlin.mff.cuni.cz>
	 <BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE>
	 <845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com>
	 <Pine.LNX.4.64.0610211353070.3962@g5.osdl.org>
	 <Pine.LNX.4.64.0610211655130.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, "Jan Hudec" <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 02:13:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbQxz-0006Hb-5c
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 02:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161518AbWJVANY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 20:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161519AbWJVANY
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 20:13:24 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:28677 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161518AbWJVANX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 20:13:23 -0400
Received: by py-out-1112.google.com with SMTP id z74so39386pyg
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 17:13:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=peBRmxHxaK8+vwSMMVMiGurdfNHsGixBH0zx6osFz7nVN1feU6orFoWKN9z4QL+WH5i2kTpyAoSSZlox9/LTNzAxrTQxsulPPRwHq1CW7ZJMH7YAfV5HRc8jxXmLFkWmPNNcsJ1sRwobByInYZAUFwNWv7gwip/Hyc983wuGfLU=
Received: by 10.35.61.17 with SMTP id o17mr3659795pyk;
        Sat, 21 Oct 2006 17:13:22 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Sat, 21 Oct 2006 17:13:22 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610211655130.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29696>

On 10/22/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sat, 21 Oct 2006, Linus Torvalds wrote:
> >
> > And that work-flow is definitely not "distributed" it's much closer to
> > "disconnected centralized".
>
> Side note: the only reason I think that distinction is worth making at all
> is when comparing git to bzr, and even then this is a fairly subtle
> distinction, and probably not a huge deal in practice.
>
> I obviously think git is a nicer distributed design, but in the end, if
> you compare to something like CVS or SVN that isn't even disconnected, the
> difference between git and bzr in this sense is basically zero.
>
> So I sound like I care, but at the same time, I realize very well that
> when coming from a totally centralized world, the details we're arguing
> are _so_ not important.

I have to agree. Personally I think both git, bzr and mercurial are
all VERY nice systems.  If they weren't all started about the same
time, I doubt we would have all three.

I am happy to use either, but I have a small preference with bzr
because it suites me. I'm saying this, just as a user, nothing else.

/Erik
-- 
google talk/jabber. zindar@gmail.com
SIP-phones: sip:erik_bagfors@gizmoproject.com
sip:17476714687@proxy01.sipphone.com
