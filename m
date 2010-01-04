From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: edit Author/Date metadata as part of 'git commit' $EDITOR 
	invocation?
Date: Mon, 4 Jan 2010 17:52:42 -0500
Message-ID: <fabb9a1e1001041452q299f1f28hff041eb06fd24b1f@mail.gmail.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com> <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com> 
	<xuu2zl4tfuij.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Adam Megacz <adam@megacz.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 23:53:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRvnS-0003s4-Ea
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 23:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab0ADWxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 17:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484Ab0ADWxG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 17:53:06 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:56975 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab0ADWxE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 17:53:04 -0500
Received: by pwj9 with SMTP id 9so9660049pwj.21
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 14:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+pij1pTNM2p7n92JFD1AE4L5eMAbRODRK6DcjA0GYs0=;
        b=RhLnkFkKdi4z9rwJ10OGLMsj8+YIioeEZwWdpmoKBeyyuKjgauyXk983xVz7/a0AFj
         pJupN6+Dnm0prMsnh4laADSlTYqwGZ6BbWdfjLTd9wnj9tsb6lprW+l4M7TYVzmQxjmM
         dSTu0SshaWtnRwIZ8fcU5aM/K/LHRz1IvmiCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FtOyWusWtRwz8P9TcxfAA3k3A+fZnNkA7ZeXKC+9IKTKrlh2HXJZnEuZKSUZQjjBFh
         M9taVIzpcnbvargdGCjvh6afs0RWnqIqFv2DIqrvSALXvTeDoCQSbHPuVhjNHBgavM/s
         eWaP8n42g0v5GbX3yAIenRMNexXDm7vvutf+I=
Received: by 10.142.74.11 with SMTP id w11mr2747084wfa.110.1262645582115; Mon, 
	04 Jan 2010 14:53:02 -0800 (PST)
In-Reply-To: <xuu2zl4tfuij.fsf@nowhere.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136147>

Heya,

On Mon, Jan 4, 2010 at 16:08, Adam Megacz <adam@megacz.com> wrote:
> Perhaps a preference (off by default) demanding that they be set
> explicitly when "git commit -m" is used?

Heh, what use would that be? On a different/new box you would have
neither that setting nor the email set, so that doens't solve the
problem methinks :P.

-- 
Cheers,

Sverre Rabbelier
