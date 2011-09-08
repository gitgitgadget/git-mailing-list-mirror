From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Add interactive patch menu help scrolled away if hunk is long
Date: Thu, 8 Sep 2011 16:43:29 +0200
Message-ID: <CAGdFq_h-ueqnnaEB9Li+=qfdydRjFoP1v+cEc6A_hnc5oHBfDA@mail.gmail.com>
References: <loom.20110907T143944-529@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 16:44:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1fpv-0004Ev-GA
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 16:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab1IHOoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 10:44:10 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36032 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab1IHOoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 10:44:09 -0400
Received: by pzk37 with SMTP id 37so1239361pzk.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3OeU+cC83f2Tf15oqw1b1Bpp+NUEgLVfZn+55craZg8=;
        b=VRLwSeCbNEGXQE8pcbghNJuPHWVkmWJrvFmS1J37uszcITONuO63OdaKyiHuCoaa+P
         VZy7RVJwfwR8yBdjtwOsjDJacXGOK7ycNfSgNOHeEET/y3K+tSNeK+IXTAYO/67kZX+Y
         wtygT3rDqTaXPAnwDCqXMPn73zF8jAHni9d3k=
Received: by 10.68.38.103 with SMTP id f7mr1125166pbk.500.1315493049077; Thu,
 08 Sep 2011 07:44:09 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Thu, 8 Sep 2011 07:43:29 -0700 (PDT)
In-Reply-To: <loom.20110907T143944-529@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180975>

Heya,

On Wed, Sep 7, 2011 at 14:43, Sergio Callegari
<sergio.callegari@gmail.com> wrote:
> Probably it would be better not to reprint the hunk when '?' is selected.

Seconded! I was trying to explain git add -i to someone and typed '?'
three times in a row wondering why it wasn't working.

-- 
Cheers,

Sverre Rabbelier
