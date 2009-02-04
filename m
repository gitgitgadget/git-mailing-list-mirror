From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from the 
	git configuration
Date: Wed, 4 Feb 2009 09:08:56 +0100
Message-ID: <551f769b0902040008o7e833b93ud94eeb87dc072084@mail.gmail.com>
References: <1233695594.8042.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 09:10:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUcq5-00006A-CL
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 09:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbZBDIJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 03:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbZBDII7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 03:08:59 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:34838 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbZBDII6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 03:08:58 -0500
Received: by fxm13 with SMTP id 13so2873705fxm.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 00:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d7EHaUveR6XWInBrtRbu+VyeWAnPMt0FoLVg6yTcm8w=;
        b=UY8kcQ5oHz7IOfNxiWWBhz49Ac7P9hZ36wulrQdyflSFa+A4e6+PDb+oWKxS7r3rb5
         mcp+vTYt4THQowbDgVmjodM/r6UrqwdZ1fVhLcNPToNVihH5fUsityNdMa8B81mAi0Yc
         mP0EJ1ze3R9IK03Lle8a0UfOxXB0izEPTbuDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w/cAhI5AuSbsMiEfd2USK+i+w4fLlRlfCIG7n2ME6v/V/4UKfGJGFpkLBA5wdFfE3B
         t4vlSeya0832UgmIZRp2qrzrg+RCMI9OUZ8+hPfYo7AExFLubyDFvoB+LXuBskiB5nex
         /PsWDGRVFdeDos7AhOSnQOh+rRN5VnsSYcAAI=
Received: by 10.180.224.4 with SMTP id w4mr726698bkg.174.1233734936877; Wed, 
	04 Feb 2009 00:08:56 -0800 (PST)
In-Reply-To: <1233695594.8042.6.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108308>

Sorry to all, there is still 2 trailing whitespaces in this patch.
I send a wrong version..

I will anyway send the patch again after dealing with the comments.

Yann, bad man for patches
