From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/5] Sequencer: working around historical mistakes
Date: Sun, 13 Nov 2011 16:12:01 +0530
Message-ID: <CALkWK0kMvHj6ZfMqZwZ91PV88d0wmSRZim6jQ12Mm3xqsVoWDg@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com> <20111105234312.GB27272@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:42:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXW8-0007Hy-DB
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab1KMKmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 05:42:24 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50933 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab1KMKmX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:42:23 -0500
Received: by wwe5 with SMTP id 5so3158317wwe.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=T45HIYAf+zCcFwYxHgIBswfhdw5z6NnIXnquw9YgPKQ=;
        b=G2Ipsz95Tm99DOA++z7TiEtbnnTVXqI+HU+p7VmroPWLDPwUxZkd4vZQH62PeoO3hV
         Pz7ttG4v7DWd6MvYlwlJg+sxvYlrpsGfwD6iXe7sNpJafhdBrVIsCeTu5hX2cS+r6PaS
         xTkCOrblJKqqUaZrFmg3ouV7RfDHetO2/Ykoc=
Received: by 10.216.133.155 with SMTP id q27mr425397wei.101.1321180942085;
 Sun, 13 Nov 2011 02:42:22 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Sun, 13 Nov 2011 02:42:01 -0800 (PST)
In-Reply-To: <20111105234312.GB27272@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185328>

Hi,

Jonathan Nieder writes:
> Shouldn't it be based against rr/revert-cherry-pick, rather than
> "next" which is more of a moving target?

When I read this, I went: "Now why didn't I think of that?"

Thanks.

-- Ram
