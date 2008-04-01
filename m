From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: [PATCH] Add new git-graph command
Date: Tue, 1 Apr 2008 00:05:17 -0400
Message-ID: <9b3e2dc20803312105i1f890784v29928321e3e51374@mail.gmail.com>
References: <20080330195840.GA8695@adamsimpkins.net>
	 <200803312017.28354.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Adam Simpkins" <adam@adamsimpkins.net>
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 01 06:06:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgXl3-0003pD-V0
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 06:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbYDAEFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 00:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbYDAEFT
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 00:05:19 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:51535 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYDAEFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 00:05:18 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1107855rvb.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 21:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E4ngnkLzwXh5mUbhAUBjHUKO1Yzmeo1Tp42vq0INkPY=;
        b=OQj56yRjClvTWVGVDjf0gEvHOUMlmhdvUOc8APsCY6Ujj0d5iNgZrdiDPO2Zr1JHsz3sxFJouK1/egbvVSfDGqlW28KdYturWmvX8QtuvU6JCbK0MZ+/51+t8v49JIZrT8WrFTm5s9p4OqtwOmlXPE5jK4WMr9O5CWqVJ6o3Oeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WgJWV73nbGWPuogbIWNFjtGL6xGlD2QANVCkeZZngvWiYScU2ClBK9fQJEesmZFl/e22OI7CzDZtxrX5BhmQMf32x5IBUSIVNi0o5ciduSjA7muaux+FENugEE/ygfx495yRAXEU/MjLG+tq7Ljt2vN8jwjLgdfebTt2a055Drs=
Received: by 10.141.177.2 with SMTP id e2mr3942075rvp.268.1207022717860;
        Mon, 31 Mar 2008 21:05:17 -0700 (PDT)
Received: by 10.141.66.3 with HTTP; Mon, 31 Mar 2008 21:05:17 -0700 (PDT)
In-Reply-To: <200803312017.28354.tlikonen@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78624>

On Mon, Mar 31, 2008 at 1:17 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
>  I just want to say that I really like your 'git graph'. I would like to
>  see it integrated to 'git log', perhaps as 'git log --pretty=graph'
>  or 'git log --graph'.

Any reason?

I don't see why it's necessary to bundle all useful commands into one
big super-command.  I like the idea of typing "git-graph".
Then again, I happen to like the git-command syntax which seems to
have fallen out of favour, so don't pay attention to me.


Steve
