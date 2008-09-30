From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's cooking in git/spearce.git (Sep 2008, #04; Mon, 22)
Date: Tue, 30 Sep 2008 14:45:30 +0200
Message-ID: <81b0412b0809300545m7bc39fb8v2a724c05141d8d37@mail.gmail.com>
References: <20080929184709.GB21310@spearce.org>
	 <81b0412b0809300400i164525ealce8a3ff8dabf783@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 14:47:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkect-0000iD-FP
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 14:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbYI3Mpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 08:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbYI3Mpe
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 08:45:34 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:42911 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYI3Mpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 08:45:33 -0400
Received: by an-out-0708.google.com with SMTP id d40so128045and.103
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HT3+4tI3NuFnCcXdmzS0+Lc+slYojVems2K8gLkrRcI=;
        b=EdzbP2O+d2WKFnhXcnn8KzreZCeglxfRD4OuIz4cCLWFTJGz3GlFuUQ3VVpP0RLA3a
         kH/J/DV79Uu5E3GusjtF+lmK4XcWZm8scIIryMez0txELOfdzpiYSK+oqeATTHVGqPPu
         wrxlIcNcVPqE7SJ1Ii3IVg9MPU+FL8IS2UED0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DPOa0rSl0BabUvEsModjuihe6rBSKMDk76m3kVIHisLQ3NzAz/KdJINbA4K1v88WUc
         0M7SCrWWkZWnnmYWL5aTqwnx118yuH4eghRCzAqIGS4vngPn5LbkoE5Ev+hcEFyKEDFt
         yOmeeFddxfX3qwTAeKLY2OPcZaEvNVJrDlEkw=
Received: by 10.100.105.15 with SMTP id d15mr5843393anc.33.1222778730480;
        Tue, 30 Sep 2008 05:45:30 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Tue, 30 Sep 2008 05:45:30 -0700 (PDT)
In-Reply-To: <81b0412b0809300400i164525ealce8a3ff8dabf783@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97106>

2008/9/30 Alex Riesen <raa.lkml@gmail.com>:
> 2008/9/29 Shawn O. Pearce <spearce@spearce.org>:
>> Here are the topics that have been cooking.  Commits prefixed
>> with '-' are only in 'pu' while commits prefixed with '+' are
>> in 'next'.
>
> Would you mind adding the remove_path factorization patches
> in there somewhere?
>
> http://marc.info/?l=git&m=122246984212129&w=4
> http://marc.info/?l=git&m=122246997012269&w=4
>

Oh, I see: they're in your master
