From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Applying the changes of a specific commit from one branch to 
	another.
Date: Mon, 2 Mar 2009 15:52:28 +1300
Message-ID: <a038bef50903011852m1394d444tac5462d3a03906bb@mail.gmail.com>
References: <22280717.post@talk.nabble.com>
	 <a038bef50903011758v11706f27v897df8b6d0d9ca7c@mail.gmail.com>
	 <22d8f6460903011824t18c01d83p16c05af9f9a12ee5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: omar-uk <omarnetbox@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 03:54:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdyI5-0000rc-Fm
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 03:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410AbZCBCwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 21:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757248AbZCBCwb
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 21:52:31 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:2729 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160AbZCBCwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 21:52:30 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2046981rvb.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 18:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OPwjrMG5UFtq+irOph4H3tU9xN6DHbUhf2S2XwvEtPc=;
        b=a4wVAekoSesd+IpV20jNKXVn+YJFJlLurdPaanwZaFdvz7JCdAkOVTYrJXQqaKf2Ms
         NyybLvhIQjBTzswGDSX86Xw3wJsHXPcKXhERt+9b1hJk/4AmMSQKQ/Tril2ZlB+mQi5+
         y0mGxriFgg7QM2AzdMkeiY/DoijIUDwPTHICg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QPvDUl96wowY0Wm7IkXDYQYtarkjPjoSUFrxyQb/0S9sor18dHFR+SEL0mMfJ9b175
         Vra9EE3xHM1X+NCrIA9Ut+vMSEcX4h+PR0iBv3CFPWK94bn+C+brYjgRhhH2UO6b/1nr
         iGspSEpVKE2R3EUoCiyNa2bfYcCHWOJS/rVu0=
Received: by 10.115.107.1 with SMTP id j1mr2410100wam.165.1235962348876; Sun, 
	01 Mar 2009 18:52:28 -0800 (PST)
In-Reply-To: <22d8f6460903011824t18c01d83p16c05af9f9a12ee5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111901>

On Mon, Mar 2, 2009 at 3:24 PM, omar-uk <omarnetbox@googlemail.com> wrote:
> Many Thanks Chris! for the quick response.
>
> What I do right click on? I tried the commit message but not getting
> any menus or anything. BTW I'm using a mac not sure if it makes a
> difference.

Hmm, Doesn't mac imply only one mouse button? Anyway whatever the
equivalent to right click is you click on the headline (also referred
to as the subject) in the tree (top half of the gitk window).

Also for mac a lot of people are using GitX which has similar
functionality to gitk (I can't claim any knowledge about it).
