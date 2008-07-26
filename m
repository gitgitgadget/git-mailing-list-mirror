From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 2/5] Add git-sequencer documentation
Date: Sat, 26 Jul 2008 10:26:47 +0200
Message-ID: <bd6139dc0807260126u2f9e4902j8721b39d19ae340d@mail.gmail.com>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net>
	 <1217049644-8874-2-git-send-email-s-beyer@gmx.net>
	 <1217049644-8874-3-git-send-email-s-beyer@gmx.net>
	 <g6emhb$p1a$1@ger.gmane.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 10:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMf80-00089k-2M
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 10:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbYGZI0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 04:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbYGZI0s
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 04:26:48 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:17228 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYGZI0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 04:26:47 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4593136wfd.4
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JFzHl+Ul+lwWYN03cUP20BPQ57Tch4WnjUeIxvrkRO0=;
        b=qpQq5WUBzk5ZVaEigMyqUQtvbkZDxAx1afoUDOjBrLe80Wm25ZOMnG5Jp9MbTTYUBu
         oykztjLnKyFY6ZvuRsgxW2+unLTr5K8IW0GvsR1buTCHO+ARv//lmuXfMgT6sii7zdoA
         pVxbHxBVjx/ro2ooQqKO2gYtMud2o4gMV5lns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=rZn2n065AsIQYBbBf3Yhkt45sFmOc9ry/dmj8r/F0wxO5s/MgvaX78oCzHZiUZA0IA
         kPMjAZzYtOi2YStmtmNRz54oP6U6wRT1RU/2X+yYg/cqu9wuXiPyBtY8RqCJnGttKj/A
         HbXrCP/7MzLf49mexp/fXACIlhhQTMigV2aZs=
Received: by 10.143.41.5 with SMTP id t5mr845297wfj.216.1217060807218;
        Sat, 26 Jul 2008 01:26:47 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Sat, 26 Jul 2008 01:26:47 -0700 (PDT)
In-Reply-To: <g6emhb$p1a$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90200>

On Sat, Jul 26, 2008 at 10:16, Jakub Narebski <jnareb@gmail.com> wrote:
> Stephan Beyer wrote:
>> +All characters after a `#` character will be ignored until the end of a line.
>
> Probably should be 'are comments and' somewhere...

s/ and$//
s/^/and /

-- 
Cheers,

Sverre Rabbelier
