From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/6] Teach --id/-d to "git status"
Date: Wed, 5 Aug 2009 11:30:05 -0700
Message-ID: <fabb9a1e0908051130s3cd0965cy4a5b5430ffb2b0a8@mail.gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com> 
	<1249465906-3940-2-git-send-email-ayiehere@gmail.com> <81b0412b0908051111g4433e12epa540e0a2f07b62b@mail.gmail.com> 
	<fabb9a1e0908051125m3eecb065m5fb4ea2b55f69b91@mail.gmail.com> 
	<7vtz0m5d61.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlH2-0007gM-RQ
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbZHESab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbZHESa3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:30:29 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:8005 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbZHESaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:30:25 -0400
Received: by ey-out-2122.google.com with SMTP id 9so211716eyd.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VT5pdiCo5nNnmem1eqeiWTW6qrjInGLYXocjB/7njmg=;
        b=o9vLW6yTFodYQw7YJcShm3IWNdesVVNQw97FtXWuMp3M7QUHm2ir6gahkmdv78ZyMf
         HZF5TfDZ5PCZ9MubD9HTh5UFXzVX3wgQibTGw0lQRkpIhARQED2cfl/BCXqdBUFYjtAR
         l6gxsCEWcnu5Dro/0Orar+OmFAHok9V+kWTWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=exvLzYEh0VPTKl9Yxm2vjb9NjL5opE1w2Cp1dudNgwaxeZfifK4Mc4xXJQkONK+TW+
         oDKVOVacbQ1hWfhqKCAGBAdhRae/DQFx5Qk3R/n5HRwuvxaQFdnfcvTe8IiQAErG/1ay
         CcuXkPy20HJg9RDsNqZJKNdjbm66tzuV2jjZY=
Received: by 10.216.91.15 with SMTP id g15mr1770934wef.24.1249497025135; Wed, 
	05 Aug 2009 11:30:25 -0700 (PDT)
In-Reply-To: <7vtz0m5d61.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124945>

Heya,

On Wed, Aug 5, 2009 at 11:27, Junio C Hamano<gitster@pobox.com> wrote:
> Sounds useless.

It's actually called "[PATCH] RFC - Say goodbye to the rodent"; can't
find it on GMane though.

-- 
Cheers,

Sverre Rabbelier
