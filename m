From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Global .git directory
Date: Tue, 27 Apr 2010 22:26:30 +0200
Message-ID: <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>
	 <201004271159.34071.trast@student.ethz.ch>
	 <alpine.LFD.2.00.1004272144470.11216@bbs.intern>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 22:26:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6rMc-0003jl-TZ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab0D0U0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:26:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58132 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab0D0U0c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:26:32 -0400
Received: by wye20 with SMTP id 20so220970wye.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=GE2cl1SUN9asgGhA50zZiQ7OS3AKNHBAL4++X6x1dKo=;
        b=ZlFA6929WfpIW60MdKM6DMKrXk8SoR8tQ2oIgnyCNQ4xtQNy3R1oQfzQ2K4I0tJdh0
         qdxugmMGweEo4BJROeqxEX1g2H+7KBYrMP536Zryc85p3JLi07BgW0oqXGYD3y2/PYCP
         uIGJyhnMI9vHYXfj+R+SBy7JW1+EpjH6nHSX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=ATusSMC2qDUH6ox4wzcfAYryDnQ6tfJb7X16KIouMMzFZVzJsTfN1rWTfl2IYJGT9r
         ivaoboFSN/c9RLadj/Yfu6WLCFWH0y/EFpLg0z4R+64gqcnUhnVK/fsD1Vbxt0bKr4zy
         nwF58kYCMcQ3ubGZHTLweRer++sqkeVULoKzQ=
Received: by 10.216.90.145 with SMTP id e17mr2583095wef.106.1272399990765; 
	Tue, 27 Apr 2010 13:26:30 -0700 (PDT)
Received: by 10.216.51.79 with HTTP; Tue, 27 Apr 2010 13:26:30 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004272144470.11216@bbs.intern>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145946>

On Tue, Apr 27, 2010 at 10:06 PM, Gerhard Wiesinger <lists@wiesinger.com> wrote:
> On Tue, 27 Apr 2010, Thomas Rast wrote:
>> (In other words, please convince us that this is actually worth
>> having.)
>
> Ok, rather than convincing I've written a (fast) patch which works for me
> :-)
>
> Any comments? Any (further) changes needed? Will you include it in main git?

Please see Documentation/SubmittingPatches. It's difficult to comment
on a non-inlined patch.

-- 
Erik "kusma" Faye-Lund
