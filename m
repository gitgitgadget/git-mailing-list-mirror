From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Support triangular workflows
Date: Mon, 18 Mar 2013 10:32:51 -0400
Message-ID: <20130318143251.GC23075@sigill.intra.peff.net>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
 <20130318142526.GA23075@sigill.intra.peff.net>
 <CALkWK0=D6JmocJJcLJTV6z-TcyuJL35cDpozaa6t64V_W2KSRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 15:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHb7q-00068T-SV
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 15:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab3CROc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 10:32:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56111 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab3CROcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 10:32:55 -0400
Received: (qmail 17780 invoked by uid 107); 18 Mar 2013 14:34:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 10:34:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 10:32:51 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=D6JmocJJcLJTV6z-TcyuJL35cDpozaa6t64V_W2KSRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218420>

On Mon, Mar 18, 2013 at 07:58:23PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > On Mon, Mar 18, 2013 at 06:46:11PM +0530, Ramkumar Ramachandra wrote:
> >>  Documentation/config.txt | 23 ++++++++++++++++---
> >>  builtin/push.c           |  2 +-
> >>  remote.c                 | 60 +++++++++++++++++++++++++++++++++++-------------
> >>  remote.h                 |  1 +
> >>  4 files changed, 66 insertions(+), 20 deletions(-)
> >
> > No new tests?
> 
> Honestly, it slipped my mind.  Will write it now.
> 
> Thanks for the reminder.

Thanks. Other than the suggestion I made on 2/4, I do not see anything
wrong with the series.

-Peff
