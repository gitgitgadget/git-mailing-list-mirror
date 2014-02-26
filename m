From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 18:16:49 +0700
Message-ID: <CACsJy8Bw7JqokgGt46T7Xivk08F-DS4Dj-j1PWxoStu=cVzo5w@mail.gmail.com>
References: <20140225154158.GA9038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:17:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcUP-0002TC-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbaBZLRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 06:17:20 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:64840 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaBZLRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:17:20 -0500
Received: by mail-qc0-f176.google.com with SMTP id r5so1055692qcx.35
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 03:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8H7gfmmKFxIPDWilxDwQASh7UCeg/E4F1xdg9keVYHw=;
        b=MuTDAm+BF/WVgK5Q3eQn6NoNBuordPD2ljrdw7iAgBNlDryuyqbsM0xpA8UP2+27ib
         lea3kbUmsQTwO57ZtA7ROuPtT4ydlQNFYAxtl3fQt4At4/P0VJ0es9hyRvSr+7NPw4U5
         As/7mGBrcrFQ8aBNhk49GbHqLTG07RI5cUt75PlSZjsxya8UkIAqP8MQN1RikcFV1Q4K
         OGxMyUYbn55QDEJ/3bUWCAAxCfIVn3G6SMhZICZOLEWG808ugSZyX9jfFNtmmAqlcgXE
         ASP3/jQIw6UUUVyOl1W5HJdiag7sTkrQaG26oMZW0h+B4w4gutLxFmQte7l15emM9Q79
         nA6Q==
X-Received: by 10.229.241.9 with SMTP id lc9mr9218940qcb.15.1393413439446;
 Wed, 26 Feb 2014 03:17:19 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 26 Feb 2014 03:16:49 -0800 (PST)
In-Reply-To: <20140225154158.GA9038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242722>

On Tue, Feb 25, 2014 at 10:41 PM, Jeff King <peff@peff.net> wrote:
> I'm pleased to announce that Git has been accepted to this year's Google
> Summer of Code.
>
> Student proposals will start coming in on March 22. In the meantime
> students will be reading our Ideas page[1] and enquiring about the
> program on the mailing list and on irc. There are many ways that
> existing git developers can help:
>
>   - continue to add to and polish the Ideas page

One thing I noticed after tg/index-v4-format is both libgit2 and jgit
do not seem to support index v4. So we could add "index v4 support on
libgit2" to the idea page. It's a relatively small task though once
you get a hang on index format.
-- 
Duy
