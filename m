From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 15:24:28 +1100
Message-ID: <ee77f5c20801152024s1a30e5d2o575b74fce2e9e1f1@mail.gmail.com>
References: <478D79BD.7060006@talkingspider.com>
	 <86hcheig3n.fsf@blue.stonehenge.com>
	 <478D82FA.2030404@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzpi-00041E-5Z
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500AbYAPEYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755641AbYAPEYa
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:24:30 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:11863 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbYAPEY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:24:29 -0500
Received: by rv-out-0910.google.com with SMTP id k20so92785rvb.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 20:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gBpBALIhrYrgBIARBe6rrtcy6Xz48rFMAj+7GkYrOPg=;
        b=GjgjIOGsFowsMH2ux3PvNQZXpGdAtyfaho2FFaYxCWGNpPVg1Fk72JAtgL7K6XVxmGDnqmYwBCQK2PgwAtXhJ65MjdQi1fYOk4LEUS8g+x5w2wHzu/hOLkLj68UnLP+UcNRZDGpmN+1g+W+xnp7ffluhuEwD/BFTYG+d7A8okZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oYaQgX/nQGlUxSA/c4m7B0xDRtWn2RSDPAoX25jdjIDFodjcjh9J9EFGP9wlHVNEUO0uBi575egIe6GlYPK3A56ysJUYYheyDM/WdQmBPykDCyhuLRmzIqyIOfzYmfP/6IhiAgE17m23eU+FmlCUxtcRbg0NRlJw+2r9LWDkiNA=
Received: by 10.141.190.9 with SMTP id s9mr233799rvp.125.1200457468961;
        Tue, 15 Jan 2008 20:24:28 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Tue, 15 Jan 2008 20:24:28 -0800 (PST)
In-Reply-To: <478D82FA.2030404@talkingspider.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70625>

On Jan 16, 2008 3:07 PM, Mike <fromlists@talkingspider.com> wrote:
>
>
> I got:
>
> $ git archive --help
> No manual entry for git-archive

What's your git version ("git version")? Try just "man git-archive".


Dave.
