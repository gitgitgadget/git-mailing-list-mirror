From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 12 Dec 2008 20:24:02 +0100
Message-ID: <bd6139dc0812121124j49c80bbdhca22ddbdabc14cee@mail.gmail.com>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
	 <alpine.DEB.1.00.0812121952320.5873@eeepc-johanness>
	 <29095.1229109133@redhat.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "David Howells" <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBDdh-0000I3-K5
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 20:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbYLLTYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 14:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYLLTYG
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 14:24:06 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:64312 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbYLLTYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 14:24:03 -0500
Received: by yw-out-2324.google.com with SMTP id 9so747478ywe.1
        for <multiple recipients>; Fri, 12 Dec 2008 11:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5wBW0Kl4FCUeK6HkLgOfUEh2SIk0mM2OPPLd4hWZj1E=;
        b=nk7FhgK/erxU58hMo+Op+V6CGpIP1RvP+6tlWyTaCa7V2jp3sXXfAmwU52g1TeISCT
         B4SuwNtg+Ice7SfU2qdtEvyCiTUi8hAF7HLNKClAnp/L0E0GRwUFowQ0UHJd3QodnRs7
         vxJMDESl7MADvFhupFXwWvhDvPlnfA2PWvGBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=PcxjSasf2umFmkenUIeRkZsh3PGj/LoZWvOxEhqYgKM3W1TJHJ/qOBhsdHDbw1OTaq
         jw/rqhoKm62Ws57ORotzJH3aXCTfXx8JqzJ/6KxtXkl/jgHH1RRf6uTUpTCadET/Qkwk
         bsHLzLr25pfOu0Ssm5Q1i7KCNJ6MIC5QDE408=
Received: by 10.150.138.8 with SMTP id l8mr6915905ybd.77.1229109842343;
        Fri, 12 Dec 2008 11:24:02 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Fri, 12 Dec 2008 11:24:02 -0800 (PST)
In-Reply-To: <29095.1229109133@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102930>

On Fri, Dec 12, 2008 at 20:12, David Howells <dhowells@redhat.com> wrote:
> In my opinion, it's much easier to deal with if you can visualise how it
> works

Ah, this is of course why they teach you how an engine works at the
driving schools!

-- 
Cheers,

Sverre Rabbelier
