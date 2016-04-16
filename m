From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git mascot
Date: Sat, 16 Apr 2016 07:33:09 +0700
Message-ID: <CACsJy8Dd_UbFETAAm7bGv=j2kQRvq1FvNY7dHKb13km_SxDSiA@mail.gmail.com>
References: <CAEC5eqHEVr=k+UP8vG20L8Si-phYwZ5TLFr_dch=9_vM-99gYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Christian Howe <cjhowe7@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:33:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arEBJ-0004aA-GN
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbcDPAdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:33:42 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34549 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbcDPAdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:33:40 -0400
Received: by mail-lf0-f45.google.com with SMTP id j11so162875535lfb.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I+sfg7KY60UYFbjcZORQEM9j1Bb8butvC8SUal9CLac=;
        b=dQHTpUggDYwZ9qP/xJq2kRMhr92z/T6KM4I1/84jFxH0styPtEIb4BMAfLFNjzJ0eo
         OrlsV2iiMSs2mqWbk4Z28AoYZZmikTx9dbKyTizDL6ZWY3/601eUR/wex3i891p2i4Pd
         G3RysQHdEhzbffHXGkeJvtdpaACoM6W5A7P1rTmbO636nQA8bIFaxY+97dmT6gVH+Ui3
         ejtjZ03/8igLZBLWPZO4ZNKSh6qFCGGxviG3j1XB9IoFLuahjMSbfhdCUTJMsrXADywW
         vn2tY5GQ9rmfhaM8uFU0AF+4bk4XvedpLmKUEwClBndVvE2Omibt9rzfvkssPRig+Xqx
         J6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I+sfg7KY60UYFbjcZORQEM9j1Bb8butvC8SUal9CLac=;
        b=ByREb3x7UL8omW/oZKcXagXL9IHDyP1l53DUnuR1tUAXpqDhu6LoOyMRiwK22m943a
         mlDIU8k4/500JRpbq5Zlrpfp7PiPdl2TSX0xtAzWgO4CFUuAChbDUepEVsaT/5S4MjPM
         IANFDk8DH1dF3i0bpgN2PYh+G8dq7A4IUX2NSmmR7ZqgNDw61aOqEfi5ABMurLN/07fj
         Ip9mZMQt+4kYnKYUmxFfyntfrvSrIyugrjRZuIqhyl0Iq1bQ/i38x67mEoZLFZ+jbsjF
         bbBb4vIZnH883tAYWsfz00F26w3JxXqaj9v3rstAqq0haFTb2cTAFzv9uJTUF6ZapTdU
         fAlA==
X-Gm-Message-State: AOPr4FVXtb5kdmH0X71QjR/ro6pgCxOEMIYFAR/y69OvmwFnc6e+qp+qzQexl4b/pevFkMIA6Nar7t9w08ED4A==
X-Received: by 10.112.209.99 with SMTP id ml3mr9804801lbc.26.1460766818932;
 Fri, 15 Apr 2016 17:33:38 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 15 Apr 2016 17:33:09 -0700 (PDT)
In-Reply-To: <CAEC5eqHEVr=k+UP8vG20L8Si-phYwZ5TLFr_dch=9_vM-99gYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291706>

On Fri, Apr 15, 2016 at 11:41 PM, Christian Howe <cjhowe7@gmail.com> wrote:
> There has been talk of a git mascot a while back in 2005. Some people
> mentioned a fish or a turtle. Since all the great open source projects
> like Linux or RethinkDB have a cute mascot, git definitely needs one
> as well. A mascot gives people a recognizable persona towards which
> they can direct their unbounded love for the project. It'd even be
> good if a plush doll of this mascot could eventually be created for
> people to physically express their love of git through cuddling and
> hugging.

Given Git's horrible interface (in some cases still) and power, I'd
say an ugly witch (maybe doing something with trees). But I don't
think anyone can make a cute mascot out of that. Nor does anybody want
to cuddling :D
-- 
Duy
