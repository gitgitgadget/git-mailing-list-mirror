From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Thu, 27 Aug 2009 12:48:13 -0700
Message-ID: <fabb9a1e0908271248x3e2b03bblc2685530b14799a8@mail.gmail.com>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org> <20090826234903.GR1033@spearce.org> 
	<fabb9a1e0908261710l2a957basff5eb5d7225ce099@mail.gmail.com> 
	<20090827001207.GS1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 21:48:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgkxd-0004bB-DE
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 21:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZH0Tsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 15:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbZH0Tsc
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 15:48:32 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:40302 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZH0Tsc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 15:48:32 -0400
Received: by ewy2 with SMTP id 2so1543857ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6EQ0oUAwu0JxrOdZKQ6tMPdlPb0U9Eb3sV53FFQyazM=;
        b=kIPl28zxjcsPxurVIyOEJEIQlHeH66UVp2eNh47QS/t7hQwOAEDiXsoJEWBhsO9vqb
         LIJ95UsQJ4hO3BZAuz3pz0a2QN5QIDafoosZZYaxh+fTNoY/6kEiqTSPK3gePxhEjA0M
         eOj3mYxsumYTszWZGXcTjzp8DI0rczwlVwOOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TkODc7JdJzbvXxMC1789CKVojSi7mk8RhfNZH9+Lh/ym0i2Pg4y1+8vKrUAvCZPiTU
         j6TLXtJW/KtPfjJ8mBBL/Nx8MCHlEPJBFA+zPLcwA41igaeT0RnhkxU9pv7zrIzCNfJQ
         aSJYz2yHvyNUl5t0hU1w7iqku3WNFbL4oRZIQ=
Received: by 10.216.21.65 with SMTP id q43mr42031weq.43.1251402513124; Thu, 27 
	Aug 2009 12:48:33 -0700 (PDT)
In-Reply-To: <20090827001207.GS1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127203>

Heya,

On Wed, Aug 26, 2009 at 17:12, Shawn O. Pearce<spearce@spearce.org> wro=
te:
> RFC patch. =A0And yes, because I think we already agreed in that
> thread that the date-format option is actually a feature command,
> and not an option command. =A0The other feature commands being kicked
> around can be held for another series.

Done, see v5a of the series (I messed up v5).

--=20
Cheers,

Sverre Rabbelier
