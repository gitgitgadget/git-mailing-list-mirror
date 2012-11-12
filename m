From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/log: fix description of format.pretty
Date: Mon, 12 Nov 2012 00:05:27 -0800
Message-ID: <20121112080527.GB3581@elie.Belkin>
References: <CALkWK0=hdmYF2VoOZY4F7+yPD8D0rBnPY-tvp5pryRWp-0WBeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 09:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXp1j-0007nY-DM
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 09:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab2KLIFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 03:05:32 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39736 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2KLIFc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 03:05:32 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so4186094pbb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 00:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DBnui/Rur2AYfxUGjusuiYHiHv//6o5CEuWlnQ0FI9c=;
        b=OLf7sY6B+/O0Q0xsnZk2LFQ+w3Mm8Wse2PpD/rPpe7hmivx92uPp0Hv0qYJQWmpb/T
         u3JciPNEN9VJlnMPtz2MHjFoVoXq8xztymZ0FZduWRumg8Vhsmi2y0uEqxnoisso1jTd
         6MgyKxXhw1L0QxTC7NTkOuOpHPkfJJ6B2u0ysccg5MMn0Sx273lZzYRquFMi2d1Nuk8B
         FXL3MegRjdOahQA/hcFj3KGcCdwYkpbUS7NnqEyrEpPvGPsjzP1+SsfKM/qjEF6WtYNZ
         wNl+SkbD0J8rQIaSjDOK5Y7B48o5/hYbxwAjMzmdGPvrCygv9Hgdtq9EJ+ixqk7pA16h
         MrXQ==
Received: by 10.66.86.102 with SMTP id o6mr46571641paz.11.1352707531556;
        Mon, 12 Nov 2012 00:05:31 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id nm9sm3814679pbc.46.2012.11.12.00.05.29
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 00:05:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=hdmYF2VoOZY4F7+yPD8D0rBnPY-tvp5pryRWp-0WBeg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209470>

Hi Ram,

Ramkumar Ramachandra wrote:

> 59893a88 (Documentation/log: add a CONFIGURATION section, 2010-05-08)
> mentioned that `format.pretty` is the default for the `--format`
> option.  Such an option never existed,

False.  Have you tried it?

Thanks,
Jonathan
