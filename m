From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Sun, 27 Sep 2009 20:44:34 +0200
Message-ID: <81b0412b0909271144o26743e05uac3132cdc5b530b@mail.gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org>
	 <200909272001.48180.robin.rosenberg.lists@dewire.com>
	 <h9o9qr$548$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: newsgroups@catchall.shelter13.net
X-From: git-owner@vger.kernel.org Sun Sep 27 20:44:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mryji-0004bY-L9
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 20:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbZI0Soc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 14:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbZI0Soc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 14:44:32 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:45509 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZI0Sob (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 14:44:31 -0400
Received: by bwz6 with SMTP id 6so870634bwz.37
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=DxU9bQ+SzbhVzDg0B/Qq3rh+yAOBpmgDEjlSBS4b0WY=;
        b=uKE0ChVjCCQpmKrcYykNGA3aTmm2roFNgzMN7V80D+dEqGYjzTnyVg0JJgejMVra3f
         pe/q9+3YifuMB4V8/+scVhT0sG4XeYAwcCZ562cWrJCY4e0QBIeMAViQbtoyj/Jdx5H7
         IoijJ43PFiSqD85ZmMrgOYXFwt1gaORupf/9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mimCqdvsHHC4uDkcZ+LishXDyLbSpPfvqayPtatO05eHjKjV9vD3DOnsCFXOYJUE84
         KEopzAWOUIqR3dAg1vaKMHoSHQBzUwDf34BiBYEPeg2HWHuRyjZdSh9zn4zX3QW1gTZl
         xVmSkmoSMdSkukv4fp+R4L3ZcKhqRyhSnTikA=
Received: by 10.204.5.138 with SMTP id 10mr2241456bkv.110.1254077074753; Sun, 
	27 Sep 2009 11:44:34 -0700 (PDT)
In-Reply-To: <h9o9qr$548$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129212>

On Sun, Sep 27, 2009 at 20:10, Anteru <newsgroups@catchall.shelter13.net> wrote:
> Yeah, well, the main question here is actually: Is improved support for
> Windows one of the goals of future git development, or is this a
> complete non-issue?

I just hope it is not. Improved Windows support mostly
means lots of dead code (and that's the best outcome),
which no other platform can use.
