From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Wed, 26 Aug 2009 17:10:05 -0700
Message-ID: <fabb9a1e0908261710l2a957basff5eb5d7225ce099@mail.gmail.com>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org> <20090826234903.GR1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 02:10:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgSZW-0000NO-Vu
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 02:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbZH0AKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 20:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752112AbZH0AKZ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 20:10:25 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:47410 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZH0AKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 20:10:24 -0400
Received: by ewy2 with SMTP id 2so710628ewy.17
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 17:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Ex6LJmElfr2i49nPYhpy4hd/GFYdxnXioCSHJWnPW98=;
        b=BDiFuU1DjoneHWYg/ydsYK1fEkXmBZhO84+KEKbBxPVJ0ClRqQcIb/9q9jAh8VyRJF
         FMZ6RsYkeflsMcbomaq1RVtQozUZrIVE7Yh1x4b+kgV7tB4go5PTtPg0zQG30nWGo8/a
         dZ1PpxWijhjHBduuTccNq37l6/Om0/4TtQmh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=enzFDc+8C68cWExC81NB6t8aGnalc16KOqXcOqPXKjHfQeQTlIvYNC9yvUqgiDjC88
         L4wu9y981Kf0/d6Eer+8zvx0ZUJ11xqTKGrklm+r4HHlbugqPYIuaJKDnPEHGG/kxdDp
         OB64kc8YkLDLUAPb0OfQ9DhiksXfhLzVelSYM=
Received: by 10.216.52.194 with SMTP id e44mr1792707wec.34.1251331825140; Wed, 
	26 Aug 2009 17:10:25 -0700 (PDT)
In-Reply-To: <20090826234903.GR1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127123>

Heya,

On Wed, Aug 26, 2009 at 16:49, Shawn O. Pearce<spearce@spearce.org> wrote:
> In that thread we have decided to slightly
> change this grammar and this series needs to be respun.

Speaking of which, do you want me to add the feature command to the
grammar and rebase this on top of that? I got the impression we were
far enough discussing that for at least an RPC patch?

-- 
Cheers,

Sverre Rabbelier
