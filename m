From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 14:14:40 -0700
Message-ID: <fabb9a1e0908131414n7f9394c7r13032a6bd346923f@mail.gmail.com>
References: <1250140186-12363-2-git-send-email-srabbelier@gmail.com> 
	<fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> 
	<20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> 
	<alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302> <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> 
	<20090813172508.GO1033@spearce.org> <7vzla3bjn5.fsf@alter.siamese.dyndns.org> 
	<fabb9a1e0908131301g4361a06es98fbf3c256c25300@mail.gmail.com> 
	<7vhbwb5tul.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 23:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbhdo-0003Nf-UF
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbZHMVPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 17:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756320AbZHMVPA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:15:00 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37851 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004AbZHMVO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 17:14:59 -0400
Received: by ewy10 with SMTP id 10so1099357ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9Kg8PiwgXjT+2SZV+9u4RYutHh8sUh1nYUp0TckiOIs=;
        b=ZT5NXEswCQGTJxhgvOQlDWscLe6zSjipQ04wDzBkdBM9FIi7SukrQ78P1z5emHNdPF
         VwyVTz91yBH9+3XvBMSc7Japjm/actASDwbllKdnG8bBhsagMKg80VKGVB1/+vQW1sOY
         UxtFxJTRQxsJduo0/PPjmrurqsq3VntqbP5v8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uS0nbadXQSHGABgvjOHO/1ks/wrJ78Eex6ZV14+PkCQAOfs05mamXev77kATb8E0p+
         Qj3TbsW00g13PX7L4rUzxtdJrZ1NlPjDcGZFyhXS2xtHG6qDJHIRNp7oDQDnk+pra1vC
         9DMhXa9myLWeP+84048N470XdGhTpoNlmY3wU=
Received: by 10.216.0.84 with SMTP id 62mr236511wea.185.1250198100133; Thu, 13 
	Aug 2009 14:15:00 -0700 (PDT)
In-Reply-To: <7vhbwb5tul.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125877>

Heya,

On Thu, Aug 13, 2009 at 13:42, Junio C Hamano<gitster@pobox.com> wrote:
> Heh, thanks; it appears I lagged behind by about 2 hours?

So it would seem, not a bad latency at all though.

-- 
Cheers,

Sverre Rabbelier
