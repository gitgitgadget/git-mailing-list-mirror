From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 20:19:36 +0100
Message-ID: <20130611191936.GN22905@serenity.lan>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
 <51B6AA7F.1060505@alum.mit.edu>
 <7v38sod1kn.fsf@alter.siamese.dyndns.org>
 <20130611182936.GM22905@serenity.lan>
 <51B771D5.6030809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 11 21:19:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmU6l-0003fJ-1q
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 21:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab3FKTTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 15:19:50 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:40321 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab3FKTTu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 15:19:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id A478A60651D;
	Tue, 11 Jun 2013 20:19:49 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8y1kmHLiOenf; Tue, 11 Jun 2013 20:19:49 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id F12B46064FF;
	Tue, 11 Jun 2013 20:19:48 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id DEDFA161E388;
	Tue, 11 Jun 2013 20:19:48 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q6phtlJyIzEs; Tue, 11 Jun 2013 20:19:48 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 0B15E161E467;
	Tue, 11 Jun 2013 20:19:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51B771D5.6030809@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227501>

On Tue, Jun 11, 2013 at 08:52:05PM +0200, Michael Haggerty wrote:
> That's a very good point (and a good illustration, too).  How do you
> like the new second and third sentences below?
> 
> * When reviewing other peoples' code, be tactful and constructive.
> Remember that submitting patches for public critique can be very
> intimidating and when mistakes are found it can be embarrassing.  Do
> what you can to make it a positive and pleasant experience for the
> submitter.  Set high expectations, but do what you can to help the
> submitter achieve them.  Don't demand changes based only on your
> personal preferences. Don't let the perfect be the enemy of the good.

I'm not sure.  I like the intent, but I'm not sure that it's clear
enough that we're talking about the tone of comments rather than the
type of feedback to provide.

How about something like this?

    * Having your code reviewed should feel like a collaboration aiming
      for the best result for the project, not like a fight to get your
      patch accepted.  Try to bear this in mind when reviewing other
      peoples' code and consider how you would feel reading the same
      comments if the review was the other way round.  We are only human
      and the tone of a review can influence how the following
      discussion progresses.
      
    * If you do feel that a review is aggressive, don't reply
      immediately.  Contributors are spread around the world in
      different timezones and it is often better to wait a few hours for
      others to comment before rushing to defend your patch.
