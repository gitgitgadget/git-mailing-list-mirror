From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git log --graph
Date: Sun, 11 Oct 2009 20:35:04 +0200
Message-ID: <fabb9a1e0910111135v4f3c75a7v6657f5dcfacf13ac@mail.gmail.com>
References: <c94f8e120910111127q102aa6a1qc3c0850f8a8a1509@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 20:36:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx3Hl-0002dt-AF
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 20:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbZJKSgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 14:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbZJKSgC
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 14:36:02 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:58315 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbZJKSgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 14:36:01 -0400
Received: by ewy4 with SMTP id 4so1954289ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FFseCqAGtAFckgzk6IBlktqGmkEJgAc93XcOS+9NzlY=;
        b=TZMYXJRRgbjW0Db5EJOcjA/vNvbwO8Fk1uIm4SFU29tmEf04Y4yn/UZDOceMTWYP1K
         gBGj4wgoankSNmA35fS+jgnPjon1FmVtFmzKElE0GV2Z/1nm/zhB5vPauQOHz+fiKVQl
         zfkXAArLT6rhbDkSvFDTY951AMy3B1VsBLrfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Roaad34rTobWZ7EEPm3M0UPFAGiapfwNy0q55MC/XcI9c4tv1OohRFzATlV+sKIPtI
         M9z5F1uEfPZ/OE+KT+n/eWRsiDvesKV7GdQ3/ZWt/6KCxwQmhFLX8MdjG3qDY1rG16H7
         4L3/mjS5aSxEmfTey9o9M4CCtHXExaibxZSdo=
Received: by 10.216.89.194 with SMTP id c44mr1663254wef.199.1255286124117; 
	Sun, 11 Oct 2009 11:35:24 -0700 (PDT)
In-Reply-To: <c94f8e120910111127q102aa6a1qc3c0850f8a8a1509@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129940>

Heya,

On Sun, Oct 11, 2009 at 20:27, Dilip M <dilipm79@gmail.com> wrote:
> I am trying git log --graph. (has commits in two branches...). But
> always see one line :(

It'll show you the history of one branch at a time online, you won't
get the demo-ed multiple lines unless the branch you're looking at
contains merges.


-- 
Cheers,

Sverre Rabbelier
