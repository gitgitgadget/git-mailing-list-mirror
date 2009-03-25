From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: reverting initial commit
Date: Wed, 25 Mar 2009 21:40:46 +0100
Message-ID: <fabb9a1e0903251340x637a21dav6e304aa6d2825958@mail.gmail.com>
References: <49CA7428.70400@obry.net> <7v1vsl4fxo.fsf@gitster.siamese.dyndns.org> 
	<8c9a060903251133x33749041oc2a5152097da0ae8@mail.gmail.com> 
	<gqe1kf$pg1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:42:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmZvs-0001LI-9u
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 21:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbZCYUlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 16:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbZCYUlH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 16:41:07 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:59991 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZCYUlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 16:41:05 -0400
Received: by bwz17 with SMTP id 17so231326bwz.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iu+wx0whYJrplojqENK9QcC2BCXFWBJheke3A8bSRm4=;
        b=KMWYSzWpuEhWCBF7HTbD//9NmdllNVvCLq7YwdZCrPNEq0qi4PWU9NgdZVbUWjOjIP
         gNSATyLYj2vZ1YJXiuBry9ctZ8LXycYlPmFcYfgfolATSgzV3XJ9U4s13JfskWZ8fzFe
         bPWMBV7v4SRVIR6q4CXskdIF3aqyAawD59CFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M9OpVH2GlPDG8ZLosjLuSUZ0/bWztzJuyVBzGP6YJSHVb9ZKPffTWUzbYPV4F0Ks3m
         U6of+D7T18KnA33TcMFD3w+rcdPB4kL1D8jWVTZwVkocAo4/dLt9xp6ChRl9baU6hhu1
         yQ/waIBW06IA1tusw/CEdFWw4XxxCRHgrPiKM=
In-Reply-To: <gqe1kf$pg1$1@ger.gmane.org>
Received: by 10.103.172.9 with SMTP id z9mr4376278muo.109.1238013661482; Wed, 
	25 Mar 2009 13:41:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114661>

Heya,

On Wed, Mar 25, 2009 at 20:45, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> I wish there was a way to tell rebase -i to go back to the first commit,
> inclusive, but the two or three times I've tried hacking at it I never
> managed to come to anything useful 8-/

Wasn't --root added to rebase -i recently?

-- 
Cheers,

Sverre Rabbelier
