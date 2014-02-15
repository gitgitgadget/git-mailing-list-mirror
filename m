From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git GSoC 2014
Date: Sat, 15 Feb 2014 19:35:55 +0700
Message-ID: <CACsJy8DmkBUZwgFeaoh1z=XbjdH1i6RosT-Ue1eYGwAkzH5nTQ@mail.gmail.com>
References: <20140213091037.GA28927@sigill.intra.peff.net> <87bnya8z6q.fsf@thomasrast.ch>
 <87d2iq58qk.fsf@fencepost.gnu.org> <87fvnk4ljl.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Feb 15 13:36:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEeTu-0002wb-KS
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 13:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbaBOMg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 07:36:26 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:59076 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbaBOMg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 07:36:26 -0500
Received: by mail-qa0-f41.google.com with SMTP id w8so19974445qac.0
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 04:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2pVJW91famoIKSHY3btC96PjKujrDEugto71GpmL9Kk=;
        b=U6inW777vI9YCg56i/bkAFYXFI2jNm2n2TbbdzflGqpj++jI8VzAhOWKCsxs7ZmcT4
         tdnfB8M/2i00jAanxdymk1UmLoGMc/dSRGhrnS6nt9PR/7QA0dTQESU9EZoGOXOnDh0O
         DRDtxCLpuBBj4oluyRjFnS0Md+RHNPGevjr5FG4Y/V7gJx/4Zweildg9FpegFcrtiQiV
         8VdXwwf26OlKIENEl6ghOLhgTN/x9ZeWBPtY8vBPO7GGUgYyOdNnTCcO4EIDcDZc2qYJ
         E9/Pyova8qWueLducHvqLwD/CluLnniJ1Cc94QzCr8/gBG1E0RZ61QPnwBWWj2/6V2yJ
         urgQ==
X-Received: by 10.229.118.4 with SMTP id t4mr21204765qcq.9.1392467785218; Sat,
 15 Feb 2014 04:36:25 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 15 Feb 2014 04:35:55 -0800 (PST)
In-Reply-To: <87fvnk4ljl.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242189>

On Sat, Feb 15, 2014 at 7:17 PM, Thomas Rast <tr@thomasrast.ch> wrote:
> It also includes an "ok" from Nicolas Pitre, who has been the driving
> force behind packv5 development.  The only thing that makes me uneasy is

Nit: pack v4. You are probably confused with index v5, which is also
cooking for a while now.

> that Duy is not in the list (Duy, have you been asked by libgit2 about
> possible relicensing?).

I don't remember. But for the record I'm OK with relicensing my
contributions in git.git for inclusion in libgit2.
-- 
Duy
