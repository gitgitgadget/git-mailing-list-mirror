From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 14:06:36 -0800
Message-ID: <20100113220636.GC18625@spearce.org>
References: <20100113144745.GA7246@Knoppix> <20100113161711.GB17687@inner.home.ulmdo.de> <20100113173610.GA7609@Knoppix> <20100113183520.GA23674@inner.home.ulmdo.de> <20100113191802.GA8110@Knoppix> <32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com> <20100113200629.GA8383@Knoppix> <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com> <20100113210414.GA8535@Knoppix> <32541b131001131403u162bc6ebpd551ed19aadde7fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 23:06:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVBMf-0006Ox-JB
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 23:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611Ab0AMWGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 17:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756609Ab0AMWGs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 17:06:48 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:34931 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab0AMWGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 17:06:40 -0500
Received: by iwn35 with SMTP id 35so16751105iwn.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 14:06:40 -0800 (PST)
Received: by 10.231.21.157 with SMTP id j29mr1006855ibb.28.1263420399007;
        Wed, 13 Jan 2010 14:06:39 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm5050513iwn.6.2010.01.13.14.06.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 14:06:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <32541b131001131403u162bc6ebpd551ed19aadde7fb@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136889>

Avery Pennarun <apenwarr@gmail.com> wrote:
> possible (they all suck differently), but it's going to be hard to
> convince people.  And if your new security protocol *only* works with
> git, it loses points automatically against other solutions.  (Even if
> ssh is hard to set up, I've *already set it up*, so any new
> alternative starts with an immediate negative score.)

Yup.

This is where I have trouble with gits:// thus far.

I already have SSH setup everywhere.  Even more so than I have
GnuPG configured, because I need SSH for just about everything,
and GnuPG for very little.  So, I might as well just use SSH.

-- 
Shawn.
