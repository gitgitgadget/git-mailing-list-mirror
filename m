From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Wed, 14 Nov 2012 17:50:52 -0800
Message-ID: <20121115015052.GA19131@sigill.intra.peff.net>
References: <20121113032727.GA8387@sigill.intra.peff.net>
 <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
 <20121113040104.GA9361@sigill.intra.peff.net>
 <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
 <20121113074720.GA18746@sigill.intra.peff.net>
 <CAMP44s1NdK9mw3Qz_sk1Zvg0gS6E+V0BuCfDutz8-8YD_App=Q@mail.gmail.com>
 <20121113164845.GD20361@sigill.intra.peff.net>
 <CAMP44s3sBj0iYsCLUpiouUB8PXRwLORDEyD_+dWKrSsMP+TOaw@mail.gmail.com>
 <20121115000726.GA16910@sigill.intra.peff.net>
 <CAMP44s3vYP6zR6sKxgVSoZUySxcAuR7MioMeT1WDAnU0PtZKGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:51:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYobl-0007Zk-Mn
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992597Ab2KOBu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:50:56 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48913 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992580Ab2KOBuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:50:55 -0500
Received: (qmail 10325 invoked by uid 107); 15 Nov 2012 01:51:44 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 20:51:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 17:50:52 -0800
Content-Disposition: inline
In-Reply-To: <CAMP44s3vYP6zR6sKxgVSoZUySxcAuR7MioMeT1WDAnU0PtZKGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209788>

On Thu, Nov 15, 2012 at 02:41:50AM +0100, Felipe Contreras wrote:

> But that I meant that when I introduce a regression it's like I'm
> killing all that is good and sacred about git, and when you do it's
> everything but that.

The rhetoric in this statement is a good indication that there is
nothing productive to come from our discussing it anymore.

> > If you want to seriously propose changing the behavior of "git commit",
> > I think the best thing would be to make a real patch, laying out the
> > pros and cons in the commit message, and post it. I would not be
> > surprised if the other list participants have stopped reading our thread
> > at this point, and the idea is going otherwise unnoticed.
> 
> I would, if I saw any chance in it actually going through.

Well, it certainly will not go through if you do not try.

-Peff
