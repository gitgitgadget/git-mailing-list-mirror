From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFH] hackday and GSoC topic suggestions
Date: Sun, 16 Feb 2014 21:42:30 +0700
Message-ID: <CACsJy8DMtJBiFX1Jr76QGGk=e=RhDTCge5rabA5ZZrNC5jstVQ@mail.gmail.com>
References: <20140205225702.GA12589@sigill.intra.peff.net> <87mwi1l95l.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Feb 16 15:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF32G-00032G-Gc
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 15:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbaBPOtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 09:49:31 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:64662 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbaBPOta (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 09:49:30 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so20875080qaq.11
        for <git@vger.kernel.org>; Sun, 16 Feb 2014 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aufHASvjsnkCY3AFqMydbYWDsOh2ctdMAOB1fUrNXfU=;
        b=jR40OxCNtPVhpxW+23QnEWTuNOmkOm15r3l/cgzf+cvfrpxtyOOvPJvnZbWsDA2tTg
         MzHJeNY9m/W/52VCqx61A7TgQueMci20JOOPksfwBBhxkmLe+mI1HGndoWB8tHnPb9BV
         0gLRpRSxRjhBotHuPt26wBgCptRaCcHjZ8LK3F4dlRwKB/6EG6UnxiudpNi1eTjjb+cO
         hpZXmrRXfhKKCeFnwi00LbVNtylBcrZ2LB9Z5DPU4nC2s57TRjKnpfQp0QR1iGWdOZzL
         EvL6rEHO1H7DqMvSHggZm9ymyxa6RCv7QBEwgkHlEIEf1I1fHLnxVDlGFg3Xn3dQ6L0u
         SXSA==
X-Received: by 10.140.40.5 with SMTP id w5mr26624247qgw.65.1392561781044; Sun,
 16 Feb 2014 06:43:01 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sun, 16 Feb 2014 06:42:30 -0800 (PST)
In-Reply-To: <87mwi1l95l.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242223>

On Sun, Feb 9, 2014 at 2:03 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Easy:
>
> * Add -p 'e' when it fails to apply should offer an obvious way of
>   starting from the original hunk (not the broken one) or both

If it's too easy, you can add a command to change diff display
settings (--color-words, context size...)
-- 
Duy
