X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 15:15:44 +0200
Message-ID: <845b6e870610250615t713ebeaewcab3050446fc25a6@mail.gmail.com>
References: <20061022074513.GF29927@artax.karlin.mff.cuni.cz>
	 <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	 <20061023222131.GB17019@over-yonder.net> <ehjgli$lft$1@sea.gmane.org>
	 <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
	 <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
	 <20061024002657.GD17019@over-yonder.net>
	 <87y7r6zgic.wl%cworth@cworth.org>
	 <845b6e870610241451x578efe9n77017f3a9404e81c@mail.gmail.com>
	 <453F5B73.2050504@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 13:16:33 +0000 (UTC)
Cc: "Carl Worth" <cworth@cworth.org>,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n4ydM/69D4651NeN0ferKzmUylI7rHsVjr03+9JOZWsbUC+lgDZ+A/RdHpy4S6YOk02cG/rzBJ+l4ieBWx/pm/hg7TpemAeg7zDkqpFum14l3n3bruUgl2y3PZvbKLhTza5/Jr/aFcmN9GIUz1zAewXbwvBsRXE/4iaeraf3X3c=
In-Reply-To: <453F5B73.2050504@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30057>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcic8-0004Le-Om for gcvg-git@gmane.org; Wed, 25 Oct
 2006 15:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964796AbWJYNP6 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbWJYNP6
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 09:15:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:26917 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S964796AbWJYNP5
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006
 09:15:57 -0400
Received: by nz-out-0102.google.com with SMTP id s18so81248nze for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 06:15:56 -0700 (PDT)
Received: by 10.35.66.13 with SMTP id t13mr1004502pyk; Wed, 25 Oct 2006
 06:15:44 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Wed, 25 Oct 2006 06:15:44 -0700 (PDT)
To: "Andreas Ericsson" <ae@op5.se>
Sender: git-owner@vger.kernel.org

On 10/25/06, Andreas Ericsson <ae@op5.se> wrote:
> Erik B=E5gfors wrote:
> >
> > Creates the picture you can see at
> > http://erik.bagfors.nu/bzr-plugins/dotrepo.png
> >
>
> Looking at this picture, I found a very annoying thing with bzr's
> revids: For commits from the same author on the same day, they don't
> differ in the beginning, making all of them, at a glance, look the sa=
me.
> I got a headache just trying to figure out how to read them. It might=
 be
> worth looking into in the future, especially if you decide to show th=
em
> to the users.
>
> Perhaps it's just my git eyes being used to seeing the first 4 chars
> (which is all I normally look at) being different for each different
> commit, but having to look up the near-end of the string to find the
> actual difference in bzr's revids was actually a quite painful experi=
ence.

I agree, and new formats for how the revisions should look are being
discussed on the mailinglist right now.  It's not set in stone.

/Erik

--=20
google talk/jabber. zindar@gmail.com
SIP-phones: sip:erik_bagfors@gizmoproject.com
