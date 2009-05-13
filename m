From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 17:30:15 -0400
Message-ID: <76718490905131430x6f3dcc7fv71b5c880f841be47@mail.gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	 <20090512151403.GS30527@spearce.org>
	 <20090512161638.GB29566@coredump.intra.peff.net>
	 <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>
	 <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
	 <op.utvy5mie1e62zd@merlin.emma.line.org>
	 <alpine.LFD.2.01.0905131401170.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthias Andree <matthias.andree@gmx.de>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 13 23:30:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4M1x-0001Pc-RP
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760409AbZEMVaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756241AbZEMVaQ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:30:16 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:32933 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbZEMVaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:30:15 -0400
Received: by yx-out-2324.google.com with SMTP id 3so504077yxj.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lKChKSPlZ05tm+IPsu5PVVT2gpzLc81P2NpJm8suil0=;
        b=jwhe05+n1klVmYg3GJYWUb/OTNkqqiTXYNNeuZvngHws4027Ir+YSbXno2IwQ4efj0
         nnd5kJidOfF6smdo/9uX9Qf/EO1j3DyqfuBNRROp9kTQz8WMavLmFCjXWOstyUEKyZpY
         z7+7y9nwWMDXBC3Yqq3uJjkKbmvAzQDg+2eRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fqItc7hREiaN1YYxz7X1dro8cuwT4y4DRbD2uLc1ZJ5BeRymUYtrNWPqXvUGJph5Oh
         CRswbvQHUy1e00guKFjjUeBGtrFyTNWBWHHv+ceL8zMsdxaezZ0Zr3qvuX8yLqnPkHQh
         nUq7MoGYZVGb8kzeCVDVU8loftzPqU2FHbEPI=
Received: by 10.151.10.20 with SMTP id n20mr1948369ybi.292.1242250215625; Wed, 
	13 May 2009 14:30:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0905131401170.3343@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119114>

On Wed, May 13, 2009 at 5:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I have this dim memory of somebody actually pointing to the documentation
> of exactly which characters OS X ends up decomposing.

http://developer.apple.com/technotes/tn/tn1150.html#UnicodeSubtleties
http://developer.apple.com/technotes/tn/tn1150table.html

j.
