From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Mon, 02 Jun 2014 01:57:50 -0500
Message-ID: <538c206ea4f86_79bdcdb2fc42@nysa.notmuch>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
 <53866e8562b7a_12a7a052f87a@nysa.notmuch>
 <20140529185311.GB10865@sigill.intra.peff.net>
 <5388fb283edaf_bd8167d3002b@nysa.notmuch>
 <87k392e0mf.fsf@fencepost.gnu.org>
 <20140602063607.GA27445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-fc@googlegroups.com
To: Jeff King <peff@peff.net>, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 08:57:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrMBy-0005AE-CZ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 08:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbaFBG5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 02:57:54 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:35188 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbaFBG5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 02:57:53 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so4224826oag.23
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=hUn3Drc+E2k0P6O9wsCkf4i+0b7x+DPOiKmHIg5uPP8=;
        b=knLEcKprl40XrwrebOsrf68Nj4K+IwfAHrRTPznf25zMDbf4umw34huDLNClpUQWKQ
         HcEAHMWfUC309ljRjPZfTbq22E7fGHAg65lRl2j3Ml1XbCMu0CNoNJj+5yRTRV34mmoi
         UQvVGcDIUzSTMEDZENcMq8Rk7+D8UJcJAvZRonlp6fQUEdw4Rnfq86OfnqhRlM0iaNMU
         rx2BPic3qRzJwxu52Mdgx0D44ZwTwcZlf2+TMe30LRBY3sf3hjeB4vzEXEKR8Tb5O3C5
         RLiMTGnwblWGKijRybeNk5d1m18au5imwZrJ3MOi3+3yf4Tz7AAgazcxn3Oan4hRSPt8
         +wiQ==
X-Received: by 10.60.142.169 with SMTP id rx9mr36005320oeb.1.1401692272821;
        Sun, 01 Jun 2014 23:57:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ar2sm23279280obc.29.2014.06.01.23.57.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jun 2014 23:57:52 -0700 (PDT)
In-Reply-To: <20140602063607.GA27445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250556>

Jeff King wrote:
> On Sat, May 31, 2014 at 11:52:24AM +0200, David Kastrup wrote:

> > And frankly, if I were a list moderator and software asked me through
> > this sort of coincidence whether a mail should be delivered or not and a
> > glance at it shows nothing but insults, wild accusations, threats and so
> > on for the umpteenth time, I'd consider twice clicking "Accept".
> > Whether or not I ultimately did so, this would likely contribute to the
> > delay.
> 
> I do not disagree, but please let's not rehash all of that again.

FTR. I haven't insulted anybody, I on the other hand have been insulted
plenty of times, included by Junio.

-- 
Felipe Contreras
