From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH] Documentation: Fix misspellings
Date: Fri, 22 Jun 2012 15:43:58 -0400
Message-ID: <CAA3EhHLUj0Ft5nuMpC8vqzx7d2B0YPr+crp2oaANFGKqWx0stQ@mail.gmail.com>
References: <1340389329-18325-1-git-send-email-muhtasib@gmail.com> <7vehp7p28d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 21:44:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si9mK-0007ee-7P
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 21:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537Ab2FVToU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 15:44:20 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37913 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab2FVToT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 15:44:19 -0400
Received: by vbbff1 with SMTP id ff1so1046631vbb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bWCZYLBgvn6/dZPayuTLm9qZLghy767V0Ips1OBpfXg=;
        b=wfK3vhZQcwdVXqyQ9EDriPiQICBh5VcwWG1stl9IxGiTvbFdNGgx/ziywUa99xRXDf
         qzJ7sBQ5h9ZTTJL9hY9VolWszL9JYGfFoG9lKUNXNEI1qnNROQLTbrtgq42a+ZTAfthq
         MC09/V+wZhv6s9/gtD27wqMxm5Ix9dRnU95jtIy6gg7iVzr/l8LRrlh80NlZylNXWkx4
         ZqPOzPaC/vjBwJ7eCQ5mz1PyNOgR5yWkauzuL0zDxggTOlbWynzJ21JDJFoA7ypA9WWF
         y4jQVQW9lrutBP2ffzwWgB3YJ1uHzhOpVprfDLclt6ST9fvLNP62rH6JVgSTfhI8gM82
         c+jA==
Received: by 10.220.209.72 with SMTP id gf8mr1685434vcb.72.1340394258895; Fri,
 22 Jun 2012 12:44:18 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Fri, 22 Jun 2012 12:43:58 -0700 (PDT)
In-Reply-To: <7vehp7p28d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200462>

Ok, I'll fix them too. Should I submit another patch or just update
the correct one?

On Fri, Jun 22, 2012 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks; "git grep overriden" finds a few more hits in t/, which we
> may also want to fix.
