From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Mon, 2 Mar 2009 07:33:45 -0500
Message-ID: <76718490903020433l21b98a77s574847e7484fda05@mail.gmail.com>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
	 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
	 <7d1d9c250903010909h7d92f165oc703a05e819671a4@mail.gmail.com>
	 <76718490903010949h7b64eb97ob567101fbc7e4cd1@mail.gmail.com>
	 <20090302172401.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 13:35:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le7Ma-0005Nb-Iy
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 13:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbZCBMds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 07:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbZCBMds
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 07:33:48 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:48873 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZCBMdr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 07:33:47 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2249848rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 04:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aaOHExdOqiVNEvIqSf3tC+DmkpTqjWopcnoMf2Bqm3U=;
        b=ZJXCgjSz/5VD6ASQJJYP30GXGGu+qm2Ig4AA7Drr7xT0PFreCJv6Jvqvzn+RE0nqss
         glxfFTVKdResVOmUmu3GVu24smPvDzIRoykNMDnIaZZpI67N/4nQJhlNCxckuNDj1ZAE
         WO/Wl4C1wtHW0DrVQhXKD8GE556k9CxxC4UV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NUOxNtn6RSELIFK3PeQ3H4s+sXVyCivzz63KdxxOxpL+yRBYtKZfQZ1QRd9bqaz5kd
         kKm0Bgdqx8+4uvotjXOmkEsfS8emymXI4iuCZUsYpyiRcFVgeY6bwxfPA/AadB04DNJn
         ayWKrsnGL4ARDQj8pB4xy3JDsa5RQwTqzYFEI=
Received: by 10.141.155.15 with SMTP id h15mr2905207rvo.158.1235997225803; 
	Mon, 02 Mar 2009 04:33:45 -0800 (PST)
In-Reply-To: <20090302172401.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111932>

On Mon, Mar 2, 2009 at 3:24 AM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> By the way, I don't think the lesson you should take home is the need for an escape hatch. Read the message by Junio on August 24th, 2008. Being nice and not too loud during the deprecation period kept users complacent about upcoming changes and upset them when the change finally came. Being un-nice and too loud during the deprecation period would have upset them early instead. You cannot avoid upsetting users either way whenever you change the behavior. That's the lesson you should learn.

Thank you for correcting me, and I apologize for the misinformation.

It is very difficult to balance between the users who are upset enough
by the change to be vocal about it, and the users who benefit from the
change but that this list never hears from, but I appreciate that
Junio is trying to accommodate both.

j.
