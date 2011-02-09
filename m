From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: introduce "feature notes" command
Date: Thu, 10 Feb 2011 00:06:51 +0100
Message-ID: <AANLkTikML-1UsMttWUyLNWWWnTAT5NiOVhzQReeejg=g@mail.gmail.com>
References: <20110202045826.GC15285@elie> <20110202050735.GE15285@elie>
 <201102022047.55152.trast@student.ethz.ch> <AANLkTi=bEi6J3wcex8JCowU6PRt3BKix5v67v8Ds-MN2@mail.gmail.com>
 <20110209214638.GA16716@elie> <20110209224357.GB17128@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 00:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnJ8L-0006MI-Hl
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 00:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640Ab1BIXHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 18:07:33 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56209 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab1BIXHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 18:07:32 -0500
Received: by yib18 with SMTP id 18so323701yib.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=tCwRLCwf6o1i72fArdaINLESDzfOuX5laGIjYievIgc=;
        b=V2+XUY9ZL8Ci0LBaWkyDhfB2u9RFbCP4YdlXckgfs7SIfreeUIm29Z/1Jq3N+M71XM
         PbDVGfVmHbHIN7w55aH3+MCIM5SI0RRAGBXTllPi/2EMFOojIoYEj7/sXz8RhzUDCmh5
         2w4RsOFL9ZDXMY1kcR9y2AxiMFDfCoyXuNLk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JC2sdGugoboSTQQM+j8ysVLGQrjMI4dzKpwwk8HuQR6Zml7gO5WUOMbIhNS+Yal4Fc
         tKiWlzmDJ+zVKxtSe8B7XPbmaKcrQ+XpTTjgLtqqDJOdUHXUfGUH8d13buZYZfG+T5MR
         g8uUx6BIH4S1DG4sThUk2EjzdXO552zUFML6Q=
Received: by 10.150.54.20 with SMTP id c20mr2550006yba.55.1297292851545; Wed,
 09 Feb 2011 15:07:31 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Wed, 9 Feb 2011 15:06:51 -0800 (PST)
In-Reply-To: <20110209224357.GB17128@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166453>

Heya,

On Wed, Feb 9, 2011 at 23:43, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Improved-by: Thomas Rast <trast@student.ethz.ch>
> Improved-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Acked as well. Thanks for backporting this!


-- 
Cheers,

Sverre Rabbelier
