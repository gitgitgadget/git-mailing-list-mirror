From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gittogether session notes
Date: Sat, 30 Oct 2010 12:41:22 +0200
Message-ID: <201010301241.23283.jnareb@gmail.com>
References: <20101029180530.GA18997@sigill.intra.peff.net> <m3ocachkcy.fsf@localhost.localdomain> <20101029194626.GA30406@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Oct 30 12:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC8sf-00063O-Dp
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 12:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab0J3Kli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 06:41:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58858 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab0J3Klg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 06:41:36 -0400
Received: by bwz11 with SMTP id 11so3246407bwz.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fIK7zkhMnrqpKsePGV4OMICizJBxxXE9h7zzbBxieJ0=;
        b=VWkjfhdOglkN3oLi8Y6VRTEygW5I1KgpxlvRzXvRZJhnjqkKQCGkRDCToYn8QEcYX4
         x0aITzDoOSeiZtH6a+4z7I7w1qN/b4g2441nc+q+LIDHDcM7IN5mqplmpEqIRWlxC2TI
         FEUT/daUlrh6rEarJfD+uv6Hep0jw+CtwJIAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=o9ceWBXAln30A0l0EzaXQLaK4y1IyI594RlMvK65POfuIoQbK1WH3FNI/03uZoR8gn
         KeuAPKlJ1DxXfa2bqOXTe76iaiu22YQkPsQp8QsNdTBDhpzx0h/PIsd0RvxUWkgKo9rc
         MWTE8bcgAyOijlgv2Y4eTYH57/S+AcIr1LHT4=
Received: by 10.204.129.210 with SMTP id p18mr10795467bks.85.1288435294145;
        Sat, 30 Oct 2010 03:41:34 -0700 (PDT)
Received: from [192.168.1.13] (abvq193.neoplus.adsl.tpnet.pl [83.8.214.193])
        by mx.google.com with ESMTPS id p22sm1645509bkp.9.2010.10.30.03.41.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 03:41:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20101029194626.GA30406@LK-Perkele-V2.elisa-laajakaista.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160398>

On Fri, Oct 29, 2010 21:46, Ilari Liusvaara wrote:
> On Fri, Oct 29, 2010 at 12:26:15PM -0700, Jakub Narebski wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > For anyone interested, session notes from GitTogether '10 are here:
> > > 
> > >   https://git.wiki.kernel.org/index.php/GitTogether10#Session_notes
> > > 
> > > They are mostly rough transcriptions of the talks by a few volunteers,
> > > along with slides from some of the speakers.  Some of it may be
> > > incomplete or confusing, but I'm sure many of the speakers would be
> > > happy to carry discussion onto the list if emailed.
> > 
> > Thank you all who created and posted notes, and those who posted their
> > slides.  It was a good idea to use Etherpad, I think.
>  
> Any plans to make page of notes that were posted to Etherpad? Because
> Etherpad doesn't seem to want to work for me... :-/

Unfortunately Etherpad requires modern web browser.  It's a pity that
it doesn't provide plain-HTML fallback like e.g. GMail; it would probably
have to be read-only (without write capabilities), but even that would
help.

I have reposted single notes on Git wiki, converting it semi-mechanically
to Mediawiki format:
  https://git.wiki.kernel.org/index.php/GitTogether10/bup
linked from GitTogether10 page (I tried for subpages, forgetting that
they are not enabled).

-- 
Jakub Narebski
Poland
