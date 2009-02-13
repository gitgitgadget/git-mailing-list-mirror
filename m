From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: error: http-push died with strange error
Date: Fri, 13 Feb 2009 22:58:38 +0800
Message-ID: <be6fef0d0902130658x12610aa3hd40077ab53dfab25@mail.gmail.com>
References: <1234528752345-2320994.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Prasad <maninc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 16:00:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXzWV-0003ac-IQ
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 16:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759537AbZBMO6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 09:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758934AbZBMO6m
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 09:58:42 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:65265 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759425AbZBMO6l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 09:58:41 -0500
Received: by wa-out-1112.google.com with SMTP id v33so621799wah.21
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 06:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yTRbeyDeUOfLzznaFA5yihm2OSY1cnuJbBgt08OW4dQ=;
        b=nVLSjSNnRvHapSge0CSZ9udaTgpOX6HMM4SweWPy7np+PD2MGQmvAxgPXsm8LCgDu/
         23dpUsmz2J4Iy10EU117A8KNH3gsc5OoBY9koY4NZX9KTlnt4XP/uxkUKlKoQSFgy5KF
         p58FSOCVmsZY6wr4NgY5wU6SS2Z1nvDdC2yB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R/KGTpXbOEAwXLX4H/JcKEFc7nslWZUiCp2rdUgQqboyDLCC2dxs2Qf25oXg2pxvl8
         1GfTo0tOtKcpHPjzRZ8O4lHr6NHOgfbFgWDo0ibLM6T5XXmRA0QGDfPBFmTjzneQkIyT
         B2RHFrIMXS8uKmNGrMK8V1F9mXd8n2FXfyEdw=
Received: by 10.114.61.1 with SMTP id j1mr899514waa.207.1234537118853; Fri, 13 
	Feb 2009 06:58:38 -0800 (PST)
In-Reply-To: <1234528752345-2320994.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109753>

Hi,

On Fri, Feb 13, 2009 at 8:39 PM, Prasad <maninc@gmail.com> wrote:
>
> I am facing this error below when i try to push my changes to server.
>

Could you tell us what version of git you're using? Sounds like a
possible memory problem.


-- 
Cheers,
Ray Chuan
