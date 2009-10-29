From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH 1/3] add splash screen
Date: Wed, 28 Oct 2009 20:28:46 -0500
Message-ID: <b4087cc50910281828o2a26999fr81b19dc69791abb2@mail.gmail.com>
References: <20091029002229.GA986@sigill.intra.peff.net> <20091029002400.GA1057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 02:29:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3JpE-00040h-Ty
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 02:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbZJ2B3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 21:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZJ2B3F
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 21:29:05 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:63040 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZJ2B3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 21:29:04 -0400
Received: by bwz27 with SMTP id 27so1740092bwz.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 18:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=qsczEMeoAq96KgVAQinJrz4odeua7mXCKQSAGrZ8zjg=;
        b=QaVKyZiZYvPyG9+E+Vw2ynRQ9SpQDJMwITi9XUq6q9YFsS5yptdaYM1KOOWstTiHxM
         m4szfZrfafBzc6QhntTbPo5JsHfXJdgE3L+rbgVi0K3KFvaIbTgUqyOFp7xh5vXblftD
         /Oe/Cn/UTTGFQPjiW5W3vIoh+M4L2lZld+590=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iGPua+mnM1AtXQZcbJUffeRTrhw3SmOuI8aoi0oJD83rH7tl6D17KVkv7mTg99ijoa
         REfdMDuQ7Nt4FaCachvUNJCgu7z2RK7UMs3vAlC9kzkKHfNSNVW/1xdQTOgLDojG1PM+
         BiwphJMQTvOikMcyb7x2HMyPDY6K7VrTTYu4M=
Received: by 10.239.179.98 with SMTP id c34mr897148hbg.17.1256779746338; Wed, 
	28 Oct 2009 18:29:06 -0700 (PDT)
In-Reply-To: <20091029002400.GA1057@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131547>

On Wed, Oct 28, 2009 at 7:24 PM, Jeff King <peff@peff.net> wrote:
> Because bash completion is so slow to start, we need to
> entertain users with a splash screen, so reuse the one from
> git-gui.

According to Wolfram Alpha, you're about 22 weeks off in your timing.
