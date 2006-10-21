From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 18:19:54 +0200
Message-ID: <845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	 <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	 <vpqejt76vgz.fsf@ecrins.imag.fr>
	 <20061017073839.3728d1e7.seanlkml@sympatico.ca>
	 <20061021141328.GE29843@artax.karlin.mff.cuni.cz>
	 <BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>, "Linus Torvalds" <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 18:29:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJjC-0001Ww-C0
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 18:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423355AbWJUQ30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 12:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423359AbWJUQ30
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 12:29:26 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:21951 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1423358AbWJUQ3Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 12:29:25 -0400
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by zeus2.kernel.org (8.13.7/8.13.1) with ESMTP id k9LGTAr7011657
	for <git@vger.kernel.org>; Sat, 21 Oct 2006 16:29:23 GMT
Received: by py-out-1112.google.com with SMTP id z74so41927pyg
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 09:27:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I2V6J3d2L7xAq50TjRyQrDDNwshDrcwZWiBq26q8XIIvtxT9tQNZCxD/PMhZtw14O0SOPBTqHMcObUcfMjYHEbXTM1TzsjxAf9/AjizwYZnek7kzyg6eAFg43bxST6KGosN8qqZbeh6BC5WJCEuBQTTyGjGouusmQJ+ne5paqFY=
Received: by 10.35.88.18 with SMTP id q18mr2979143pyl;
        Sat, 21 Oct 2006 09:19:54 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Sat, 21 Oct 2006 09:19:54 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.4/2061/Sat Oct 21 09:05:13 2006 on zeus2.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29630>

On 10/21/06, Sean <seanlkml@sympatico.ca> wrote:
> On Sat, 21 Oct 2006 16:13:28 +0200
> Jan Hudec <bulb@ucw.cz> wrote:
>
> > Bzr is meant to be used in both ways, depending on user's choice.
> > Therefore it comes with that infrastructure and you can choose whether
> > you want to use it or not.
>
> From what we've read on this thread, bzr appears to be biased towards
> working with a central repo.  That is the model that supports the use of
> revnos etc that the bzr folks are so fond of.   However Git is perfectly
> capable of being used in any number of models, including centralized.
> Git just doesn't make the mistake of training new users into using
> features that are only stable in a limited number of those models.

This is just plain wrong.

bzr is a fully decentralized VCS. I've read this thread for quite some
time now and I really cannot understand why people come to this
conclusion.

However, if you do want to work centralized, bzr has commands that
fits that workflow really good.


/Erik

-- 
google talk/jabber. zindar@gmail.com
SIP-phones: sip:erik_bagfors@gizmoproject.com
sip:17476714687@proxy01.sipphone.com
