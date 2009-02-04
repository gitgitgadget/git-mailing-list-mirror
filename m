From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Wed, 4 Feb 2009 17:00:59 +0200
Message-ID: <94a0d4530902040700l367322bcheeefec092098b794@mail.gmail.com>
References: <1233432317.26364.5.camel@wren>
	 <94a0d4530902032339p365df42i2b8f235430a68fd5@mail.gmail.com>
	 <1233748114.7594.0.camel@wren> <49898E2A.7070005@drmicha.warpmail.net>
	 <94a0d4530902040612v30df6ea8ifcf3e3244cf1c027@mail.gmail.com>
	 <1233757138.7594.19.camel@wren>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:02:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjGo-0004K0-87
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbZBDPBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbZBDPBE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:01:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:5749 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbZBDPBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:01:01 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1253839fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 07:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P1tLJp0E1H1NlvMMU0VHeZ3ftxBTt/HmAf6gICtq7nM=;
        b=hthyqDtQAnepIWcvdtYHT/2xDbrBv/KzLs6k2gqwaRAcTwCR8/JL7cnFwXHX0h8AUL
         BaP3K9ziyrz0eTIBgFbK4IbpkqHk7S3ySrp3sz/qd352ii7m/ap6CGrpihU7Cq3fcOJp
         xdguo5+6kBIpGDo0YZpmHdJ36huSIZ27GI9MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cciBZQrJGR9/teWM+AZM1CiP1D3D0SVErThRmFsifAaFoDAi/x4whnHyZ0+LQ69H5J
         pMjEx2KLaQNzPAQd8dqXkk2xB+p23xYktzmhgORp5gwwTFN/zNUokAf6u9DY1ekxBfre
         Ut03N3GucUYzG9DN8EtzVYftT8nJt8St76U1k=
Received: by 10.86.76.20 with SMTP id y20mr1165743fga.37.1233759659631; Wed, 
	04 Feb 2009 07:00:59 -0800 (PST)
In-Reply-To: <1233757138.7594.19.camel@wren>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108373>

On Wed, Feb 4, 2009 at 4:18 PM, Jesse van den Kieboom <jesse@icecrew.nl> wrote:
> Could you explain to me what makes it unusable for your wrt your
> workflow in gitk?

First of all I always need to resize the window, and when I do that
the columns are not updated so I need to resize the columns as well.
Same thing with the division of the history and diff view.

Then when navigating I can't click the arrows, so I have to scroll
down until I see the parent of the commit.

There are many other issues, like crashes, small format annoyances and
the --all option, but those I bet are easy to fix, I could even do
that myself.

-- 
Felipe Contreras
