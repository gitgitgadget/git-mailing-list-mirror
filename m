From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [idea] separate .git dir and the working tree
Date: Mon, 23 May 2011 14:40:57 +0000
Message-ID: <BANLkTinL_y8oAW2kQdyP-+CmdmrRWOrEsA@mail.gmail.com>
References: <AANLkTik4MjnpOzPdGy7ZDiH0in4e1DpjrhQFOHjUiEEE@mail.gmail.com>
 <20110205032339.GA15303@mg1> <20110205132708.GA18391@elie>
 <20110206002009.GA13594@mg1> <20110206004013.GB13594@mg1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: redstun <redstun@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Mike Gant <mike@gantsfort.com>
X-From: git-owner@vger.kernel.org Mon May 23 16:41:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOWK5-0005jR-38
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 16:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab1EWOl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 10:41:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47929 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722Ab1EWOl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 10:41:27 -0400
Received: by iwn34 with SMTP id 34so4818392iwn.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=x5DgjGq7puDPkMsV384u342GXMSC7yd0GmUBR+g4xC4=;
        b=u0cTWAGQ5XZIAo59ussFIBobWK8AMB1OH3b81NCe+Cbk0W29taoPYfcKATJF7gUuLC
         eiIbBEy5iZzWEvl9+V9sOYdemYK+NIoZq03fpBkn1T3yOzr0Wm1z++6Hj+sUITS5qKLZ
         BcyvQigN1+I1yzNwEq6zw84nS11EHVhqKk+u0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gXq3FZyDbf4N+Eutb14/qw0WJgb66y5Jl0XTS63OpLM/j0WVySi0l+8buxPzAJfAy9
         ef4OEsP4cXB1OFldcn1wWgVy6pB2+JnWtkopP0h6dRkkOrLg9Q3un3MAavQSesCYPW5c
         YRfN0ROQWM+0J7MnM9OdbqeAzjlgH+PCnixOk=
Received: by 10.42.159.134 with SMTP id l6mr8589143icx.16.1306161687112; Mon,
 23 May 2011 07:41:27 -0700 (PDT)
Received: by 10.42.173.72 with HTTP; Mon, 23 May 2011 07:40:57 -0700 (PDT)
In-Reply-To: <20110206004013.GB13594@mg1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174246>

On Sun, Feb 6, 2011 at 00:40, Mike Gant <mike@gantsfort.com> wrote:
> So does anyone use Mutt? And do they know a recipe to move the sender
> address to the cc list? If not, I'll figure it out.

Your `To:' header should list the sender (usually what's listed in the
`From:' header); the `Cc:' header should list everything else
(including the mailing list(s) in question).
