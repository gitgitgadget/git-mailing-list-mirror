From: Johan Sageryd <j@1616.se>
Subject: Re: [PATCH] worktree: Correct typo in documentation
Date: Thu, 30 Jul 2015 08:15:21 +0200
Message-ID: <CAP-NwxjdTc6DWbVzQu9=0K_Gz1zYf35bZX8yHFTuav7iCV4ohA@mail.gmail.com>
References: <1438211028-22403-1-git-send-email-j@1616.se>
	<CAPig+cSy7qVBwBznJDhzmx=YrPVd=GhTJkcG4Q5mh+3T5DgJGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 08:15:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKh7m-0005pi-OJ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 08:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbbG3GPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 02:15:23 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35988 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbG3GPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 02:15:22 -0400
Received: by vkci6 with SMTP id i6so7139566vkc.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 23:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=T5Y8UgnCP7gV+AUOb+fgGKFCAVLFYNzmq89L9bufjng=;
        b=Dk68ue+G5+Fx0C4q0KUhFqvsEsCV7dH5G3CXF3vrhcsgrmYxo9iDqlub3xkN+quUDQ
         04nQ28c9my6rixgXX6GlLSgmty2cyGdRYy35rXkxvF+XzofACXeUcF88tpPmahHcgjy8
         eIboeuSCV6o0HThpEWJ/YT5FGj4wZrnvfvvPu422/Ok04fAsgRJssawksDJOoywRGiab
         foiX1/eCXPjPKu1ns1YnV+yEeTU3l+EO20dF0AzH7Gi0DIH8W1n8eiK5P6Q5Qm0ieDNG
         hp9xatDZwniLgV/m4KzapsOwLcQ6gJTb0f9hfMx8Jqj73q7FDzJcY6wtzjhhQlOc3V0S
         4ARw==
X-Gm-Message-State: ALoCoQleB+ZWB0M8n5e6pelfNIQOJch8MkzXr2z3iM1l270CnvCwXR8CWvxbGNZxTMbgWQBaP/vm
X-Received: by 10.52.180.225 with SMTP id dr1mr1229437vdc.42.1438236921381;
 Wed, 29 Jul 2015 23:15:21 -0700 (PDT)
Received: by 10.31.158.76 with HTTP; Wed, 29 Jul 2015 23:15:21 -0700 (PDT)
X-Originating-IP: [217.209.53.40]
In-Reply-To: <CAPig+cSy7qVBwBznJDhzmx=YrPVd=GhTJkcG4Q5mh+3T5DgJGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274971>

> Thanks for the patch. This is already fixed in the 'next' branch by
> 2e73ab6 (Documentation/git-worktree: fix incorrect reference to file
> "locked", 2015-07-20).

You are right; sorry for the noise. I checked only maint and master.

/J
