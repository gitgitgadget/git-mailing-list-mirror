From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sat, 17 May 2014 02:11:17 +0000
Message-ID: <20140517021117.GA29866@debian>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <537693aee4fdd_3e4812032fcc@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 04:11:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlU5t-0000AI-Mg
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 04:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbaEQCLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 22:11:21 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:45075 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbaEQCLV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 22:11:21 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm4so1780136wib.16
        for <git@vger.kernel.org>; Fri, 16 May 2014 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WSMlVh1KE0CFavjb0FLuomWqAttBlELdjt1MsPfNtQw=;
        b=qsQlzn768s/4Ku/HpOqTXY4Gq4jSCliZ2qa344pC+QOTdzTGfKPIG+LFWzW3TAQ/7t
         8j+9rkWv+ImDPxC7v6aYP7wffoXW3CK+wqBvBmgS9qbbtOLIEKzTvhYXhe1tcFwmD/tI
         uDq3AMGw1VATSXeOhsPOfCvGhC5DFCKKqLITU6D8e88D28jdW9UHsNkjLSAiwtVEjE2R
         n61r8FHtU8vehLyy1cH20HNxuSpSvJbrBwg6mK4jxD6aejN5Yapy+2Fqx8PBTopDGreL
         ZV13DhYFnNjqo+GN8J0So+AguRUgg9QiGdbRZK9JHITdtiufUHB8DoUCD6Ve09USaCxE
         8IDQ==
X-Received: by 10.180.85.134 with SMTP id h6mr1078767wiz.44.1400292680043;
        Fri, 16 May 2014 19:11:20 -0700 (PDT)
Received: from debian ([2a04:1980:3100:1aac:21b:21ff:feda:4cbe])
        by mx.google.com with ESMTPSA id ch16sm4079902wjb.43.2014.05.16.19.11.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 May 2014 19:11:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537693aee4fdd_3e4812032fcc@nysa.notmuch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249436>

On Fri, May 16, 2014 at 05:39:42PM -0500, Felipe Contreras wrote:
> (...) I would venture to say you have never made a package in your
> life.

And you have, Felipe? Let us see the years of experience you surely have
in the field.

> The fact that you think packagers of git would simply package
> git-remote-hg/bzr as well is pretty appalling.

It's not an outlandish thought, in fact, I'd suggest it as probable -
provided that they find the projects to be stable and of high quality.
You, or someone else, might have to tap them on the shoulder and play
nice to _ensure_ they know about them (after all, we all know that
packagers _never_ read READMEs, do they), but you're capable of that,
I'm sure.
