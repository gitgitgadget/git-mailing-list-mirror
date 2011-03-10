From: Vicent Marti <tanoku@gmail.com>
Subject: Re: Using libgit2 code in git.git as a Google Summer of Code project?
Date: Thu, 10 Mar 2011 14:56:39 +0200
Message-ID: <AANLkTi=6huFKCqrdfvjXXfYrd0GaeZKmiEg-9UjipBKK@mail.gmail.com>
References: <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com>
 <20110310101332.GC26851@elie> <AANLkTikQ3x9A6v3y698_om_4_qB87Zpi_kG3u3=d+Dur@mail.gmail.com>
 <AANLkTi=q6mxGQcdb-Gx9t3TZWDRbNpiZV-iyjgd=NrXj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, libgit2@librelist.com,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 13:57:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxfQR-0000q0-NX
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 13:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab1CJM5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 07:57:01 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:36317 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab1CJM5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 07:57:00 -0500
Received: by wwi17 with SMTP id 17so1371746wwi.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 04:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=49xltl6OKgbjC5HztMMOzaoAkZSy8X+pmxpdZTVFJPQ=;
        b=yEfXNwww9FIjmvLu5hZBX+MarguEs2iJt3bae1AtLnzZeSQqFCFx+7lrpov1KY1bHW
         jemkxO6T+0kD6dA4YllFLwdIaDpInEGmpyddAfGvnpTgwFLACfPpWCrkF/PZHBBbRtgh
         1JG5lOC0TcubyGOaiGpL9b9eJMjp69WE9LyaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WYxB548BzLq2vSt0k7NEozoXJk9NVidLFPdTxZ2hniWwQORaolHKSI1H0fxOcdY4Ay
         h3T8taw0LEUkcwuxx6QccT8fTS/gmZcg+3qzWERP4LdsRNDhkUU9iUdbuuc0mGYd+laf
         d0MU5O+hvu0eaEIpADfrO4RHprTR+2OU73j6Q=
Received: by 10.216.145.154 with SMTP id p26mr5890338wej.11.1299761819146;
 Thu, 10 Mar 2011 04:56:59 -0800 (PST)
Received: by 10.216.244.10 with HTTP; Thu, 10 Mar 2011 04:56:39 -0800 (PST)
In-Reply-To: <AANLkTi=q6mxGQcdb-Gx9t3TZWDRbNpiZV-iyjgd=NrXj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168814>

Hey,

On Thu, Mar 10, 2011 at 1:39 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Speaking of which, how complete is libgit2 compared to git? What are
> the significant missing pieces?

You can see the key features we are lacking in the SoC2011 ideas wiki:

https://git.wiki.kernel.org/index.php/SoC2011Ideas

Cheers,
Vicent
