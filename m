From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: Suggestion for mailing lists... split [PATCH]-es into own list
Date: Fri, 12 Oct 2007 10:26:31 +0200
Message-ID: <8c5c35580710120126x51c300bfu4345b8c6315d953c@mail.gmail.com>
References: <e47324780710110857s472bf099u3e350d17a2c29f78@mail.gmail.com>
	 <Pine.LNX.4.64.0710111704570.4174@racer.site>
	 <981e6de60710120027j5f390a9tbe2a4c76db9ed06d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>, git@vger.kernel.org
To: "Simon Sasburg" <simon.sasburg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 10:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgFr1-0002d7-CQ
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 10:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbXJLI0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 04:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbXJLI0d
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 04:26:33 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:55889 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbXJLI0c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 04:26:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so917574wah
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=IVMJ5qA5B3pJtuTGaLDT3umtPO33gB0eRQvDtChQvbk=;
        b=h4WeKBhvT47gvrqrJapTs0o5+xzVtIZTakaGm3q2JUR44btN++f+aEB0lAfx7mhUvmB53L7khn37wRMyOcIuaNIPuHFCKtqHsx2eZG5JvutbYhunxEqh13xvdSphOb4Py3SYb+8Nz0WHdd9hd8FU4J8LJNyq8WOEJtZkRCZmXuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=YpFQqXtiifbhnNAy4PTrq2VDia8mgOCKrzIz/K+5cgYRbknF3W9cubJJZdYFK2e0y9Veiyhjs2f+b3ybiv8+hmF75Ocbht4JMvvohRTZe3bgo5tf/kx/HCx0VHpD8TMjM+7TPzvql4vyKjtGmuLXKeODwdFdr/HGd/lplF248gA=
Received: by 10.114.81.1 with SMTP id e1mr3250205wab.1192177591607;
        Fri, 12 Oct 2007 01:26:31 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 12 Oct 2007 01:26:31 -0700 (PDT)
In-Reply-To: <981e6de60710120027j5f390a9tbe2a4c76db9ed06d@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: d45b08c43403a937
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60663>

On 10/12/07, Simon Sasburg <simon.sasburg@gmail.com> wrote:
> On 10/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > We did not even find a way to post patches via gmail's web interface, not
> > without severely damaging the patches.
>
> Oh? Turning off Rich formatting and copy/pasting the patch from my
> editor worked for me.

The problem occurs when gmail decides to wrap the lines in the patch
(max 72 chars per line, I guess).

--
larsh
