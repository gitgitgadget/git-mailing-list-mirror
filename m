From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv5 0/8] Add commit message options for rebase --autosquash
Date: Tue, 12 Oct 2010 11:36:28 +0200
Message-ID: <AANLkTim9JuYbwpohP3tMTseLUgqe-CSM11T=N5-9-bV_@mail.gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com> <AANLkTikZJWpm054Aw51Yt2CruEtx1XfX38vsVD8wVcOX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 11:36:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5bI0-000282-DZ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 11:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158Ab0JLJgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 05:36:50 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50079 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149Ab0JLJgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 05:36:49 -0400
Received: by gxk6 with SMTP id 6so413878gxk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oyvMCq0Sx+Jn5n1kG8dgBk3gCOfckjWeB7H3tlitN5U=;
        b=tQGgzWZ/Au2HDSZVmTSafbVrPOwHF9D47ldB8OUIKeUdkxyFzKbMLHcJKFik58mlyB
         la6NQJ513BoAyTFrKmWgW2UAtYBAS04xtZP4XhDl18LtK3S05Q7nXFzJvQsp9TH24vtL
         2kMPrxUPNSvVdinMBRrKV8GnFkXHGE6bGt5yM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dOeZb81g4gDPGmaQNFxhYxN8OzhRAj2dJCWDXm3HQWcTlMATPkUi6pulu8B/soaMG9
         ryoI0bd//2bTEq31W/rJPi5BeDQg7UMGGNVZirwnGrjIfNWjhw8d+DWhGOg96d7Q2pvw
         Et9f3QYA4q1MHMmFKrr32gfFk2e9z09qERac4=
Received: by 10.150.147.11 with SMTP id u11mr8024547ybd.386.1286876208637;
 Tue, 12 Oct 2010 02:36:48 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Tue, 12 Oct 2010 02:36:28 -0700 (PDT)
In-Reply-To: <AANLkTikZJWpm054Aw51Yt2CruEtx1XfX38vsVD8wVcOX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158826>

Heya,

On Mon, Oct 11, 2010 at 23:06, Pat Notz <patnotz@gmail.com> wrote:
> I didn't receive any feedback from this patch series so I thought I'd
> just ping the list to see if this is of interest at all (I fully
> accept that it might not be). Or perhaps no news is good news. Anyway,
> sorry for the spam.

I'm definitely interested as a user, but I don't think I'm qualified
to review the actual code.

-- 
Cheers,

Sverre Rabbelier
