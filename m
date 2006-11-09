X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Dave Dillow <dave@thedillows.org>
Subject: Re: What's in git.git
Date: Wed, 08 Nov 2006 22:45:31 -0500
Message-ID: <1163043931.2943.4.camel@obelisk.thedillows.org>
References: <dlang@digitalinsight.com>
	 <200611090228.kA92SMqw006666@laptop13.inf.utfsm.cl>
	 <7vslgtpbx0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 03:45:46 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@laptop13.inf.utfsm.cl>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authentication-Warning: obelisk.thedillows.org: il1 set sender to dave@thedillows.org using -f
In-Reply-To: <7vslgtpbx0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31178>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi0rC-0003cM-WD for gcvg-git@gmane.org; Thu, 09 Nov
 2006 04:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964769AbWKIDpf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 22:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965668AbWKIDpf
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 22:45:35 -0500
Received: from smtp.knology.net ([24.214.63.101]:65444 "EHLO
 smtp.knology.net") by vger.kernel.org with ESMTP id S964769AbWKIDpe (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 22:45:34 -0500
Received: (qmail 31215 invoked by uid 0); 9 Nov 2006 03:45:32 -0000
Received: from unknown (HELO obelisk.thedillows.org) (69.73.92.192) by
 smtp2.knology.net with SMTP; 9 Nov 2006 03:45:32 -0000
Received: from obelisk.thedillows.org (localhost [127.0.0.1]) by
 obelisk.thedillows.org (8.13.7/8.13.4) with ESMTP id kA93jVxR003471; Wed, 8
 Nov 2006 22:45:31 -0500
Received: (from il1@localhost) by obelisk.thedillows.org
 (8.13.7/8.13.7/Submit) id kA93jVwV003470; Wed, 8 Nov 2006 22:45:31 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, 2006-11-08 at 18:54 -0800, Junio C Hamano wrote:
> "Horst H. von Brand" <vonbrand@laptop13.inf.utfsm.cl> writes:
> 
> > David Lang <dlang@digitalinsight.com> wrote:
> >> On Tue, 7 Nov 2006, Junio C Hamano wrote:
> >> 
> >> > [pu]
> >> >
> >> >  Johannes's shallow clone work now should rebase cleanly on top
> >> >  of 'master' although I haven't done so yet.  As he said
> >> >  himself the series is waiting for people who have needs for
> >> >  such a feature to raise hands.
> >> 
> >> I haven't been watching this recently, but if this is what I
> >> understand it to be (the ability to get a partial repository from
> >> upstream and work normally from there with the result of data-mineing
> >> tools sometimes reporting 'that's part of the truncated history' if
> >> they hit the cutoff) consider my hand raised.
> >
> > +1
> 
> What does that plus one mean?  I do not know where people picked
> up this annoying plus or minus one business, but could you all
> stop that?

Horst can speak for himself, but I'd wager he's using the Apache voting
conventions:

