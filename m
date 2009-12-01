From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
	transports.
Date: Tue, 1 Dec 2009 15:20:56 -0800
Message-ID: <20091201232056.GA29632@spearce.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com> <20091201165245.GF21299@spearce.org> <20091201171908.GA15436@Knoppix> <20091201193009.GM21299@spearce.org> <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 00:21:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFc1q-0001NV-1A
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 00:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbZLAXUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 18:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZLAXUy
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 18:20:54 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:57924 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbZLAXUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 18:20:54 -0500
Received: by gxk26 with SMTP id 26so112484gxk.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 15:21:00 -0800 (PST)
Received: by 10.90.40.31 with SMTP id n31mr9048336agn.4.1259709660479;
        Tue, 01 Dec 2009 15:21:00 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 34sm279463yxf.29.2009.12.01.15.20.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 15:20:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134268>

Junio C Hamano <gitster@pobox.com> wrote:
> It is somewhat unfortunate that a few changes I liked (e.g. the "debug"
> bit), even though it was somewhat painful to read them due to coding style
> differences, were not at the beginning of the series but instead buried
> after changes that are much bigger and controversial (e.g. [6/8]).

I agree about that debug patch, I actually thought that was
interesting, and wish I had done more of that sort of work during
smart-http.  It would have helped me to debug it in the early stages.

-- 
Shawn.
