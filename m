From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [ANNOUNCE] Push Me Pull You 0.2 - Tech Preview Release
Date: Thu, 17 Jan 2008 12:37:22 +1300
Message-ID: <46a038f90801161537r4013f30ale0ae3ecb43609cf2@mail.gmail.com>
References: <200801152131.33628.mark.williamson@cl.cam.ac.uk>
	 <7vzlv5pnrf.fsf@gitster.siamese.dyndns.org>
	 <200801162315.35288.mark.williamson@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Mark Williamson" <mark.williamson@cl.cam.ac.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:37:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHpR-0003JN-0n
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYAPXhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 18:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbYAPXhZ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:37:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:40975 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbYAPXhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 18:37:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so278291ugc.16
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 15:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WRQqt9kgtRKPXca7BHHVgdrwJG/17M3jJi9tOkYOvJg=;
        b=t848mNVwgr6rvD7ZgHsUl0IynI8RtsUMhPlSjFoLG4zA8TDFP8/IeY1m+nMXdfwSHGhUTr1K+YvpLUYIk8eImc14r/dh/rZYw+vT5gPA5v9SqmQAhYSFvhoCOEz2H2cPX3PAmEwUI4Lr95Spf/tfBhomhaiU06vE3TmO1GQToAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SxLvoS/em8xuhOdk2VIiIJwz38WZAA9WYH9UIjxKxDn8DBgNO645oeiHQWEBOJEwdhS18X86tUYyAntrU3MzhvfdbtuZtShoj/vwQH+//72AcIgdw69mGmmceY5Lg+chFWpAOfi9uQ1IeToF9hmULHOs9E9pnauOJsaJp3GfsoQ=
Received: by 10.66.254.15 with SMTP id b15mr2649939ugi.76.1200526642096;
        Wed, 16 Jan 2008 15:37:22 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Wed, 16 Jan 2008 15:37:22 -0800 (PST)
In-Reply-To: <200801162315.35288.mark.williamson@cl.cam.ac.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70774>

On Jan 17, 2008 12:15 PM, Mark Williamson <mark.williamson@cl.cam.ac.uk> wrote:
> Heheh, yeah, I was almost deafened by it :-)  But it's a new obscure tool,
> written using an foreign SCM so I'm not surprised if uptake is slow!

I don't mind at all that it is hosted with Hg ;-) I just looked at the
screenshots and description, and my feedback, as potential user, is
that it isn't clear what I would use it for.

 - What's the usage scenario for a cli-oriented power user? I do use
hg on other projects, but I'm happy to use its commandline tools.

 - For a GUI user, how does it compare with using git gui when using
git, and the equivalente gui when using hg?

cheers,


martin
