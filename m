From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: Conflict-free merging (i.e. concat) of conflicting branches?
Date: Sun, 16 Nov 2008 22:44:03 +0100
Message-ID: <2d460de70811161344n58cfb045n79b567493fef6a90@mail.gmail.com>
References: <2d460de70811160550g75e50e00gb50d3b2045c460af@mail.gmail.com>
	 <7viqqn4ouo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 22:45:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1pQp-0001K9-KB
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 22:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbYKPVoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 16:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbYKPVoG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 16:44:06 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:52251 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbYKPVoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 16:44:04 -0500
Received: by an-out-0708.google.com with SMTP id d40so950811and.1
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8MTUmJMLgEyAeTWyuUVMWrtmd1Lu6i17KumRAEMxFsU=;
        b=NVTLGXzjoo/gEcAac4dypN4BbC2ZFujDybit6uLGLMVgn+s9/09rVlp8ZaskykGmWM
         23NzjLlIIZhmVUFcYiCuHJqIzzVtg35nRAHbTrP/IW6JolejM8j2nkyr4zUUGlO7xmXE
         8YauYkoztOCrDDGKTbascLj94oPoCbsMrqrgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Q5zUJOZMlEsq6PR6UW7N+snwSjPjEI/Yrj6OTTmRydf1+mEjAvdjGrv9OoZ6sy2Qmi
         IG7x3G06Z/t1kJ1Azfx3OgSlpkXcYTIu5mdlW3f+RzG16lJiK7HQ5wMKvyxFNLeS/yXa
         fjiZ4NsFXIMhS5WRjZqVdyNu6OfDhN1tBVv/c=
Received: by 10.100.126.15 with SMTP id y15mr1337267anc.123.1226871843917;
        Sun, 16 Nov 2008 13:44:03 -0800 (PST)
Received: by 10.100.43.19 with HTTP; Sun, 16 Nov 2008 13:44:03 -0800 (PST)
In-Reply-To: <7viqqn4ouo.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101163>

On Sun, Nov 16, 2008 at 17:28, Junio C Hamano <gitster@pobox.com> wrote:

> gitattributes(5) and look for "union"?

Thanks.


Richard
