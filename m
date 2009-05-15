From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Fri, 15 May 2009 20:05:10 +0100
Message-ID: <efe2b6d70905151205r70a167a4kdc3575f4c0ec9574@mail.gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> 
	<d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> 
	<200905141701.41212.jnareb@gmail.com> <4A0CBE35.6030004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Fri May 15 21:06:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52jT-0003FG-VM
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbZEOTFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753598AbZEOTFa
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:05:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:16636 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbZEOTFa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 15:05:30 -0400
Received: by ey-out-2122.google.com with SMTP id 9so640703eyd.37
        for <git@vger.kernel.org>; Fri, 15 May 2009 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lNWjZRTDtF6NWsscj5a5gVTXvsdbRq/4EIXqAhxSwx4=;
        b=wvQdPG2bhT8UccPKOsQSq99Sz9F8rRckqUdT5w0qXOrsDxjEckEn9U7dvk6vf3VGKm
         S2tosskU94sgRQqL+XrX1BeBlMZigsVfOY8F6W/SVQHohfD7phXTt1HU0XcaSRrBKCuN
         Fe/8FGnVfp28C5q46oi0h5K4dmbyw/fVaSk6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=soE/yLOeftEiAtPt6/qViCuWLF2HEJhqiZl4v3tWkU8B82jI/PM+4X8GpBPa65gMJW
         kNRGX7bVdmydtlmnCjZRSAxP8V3zCpkHJWgw55M4iWvn9p4ZuVsGxZLDPAC1ZO+sQdFX
         OqfonjofWrIFaR14rmol/+45N3wTWmwfzVX0g=
Received: by 10.216.35.204 with SMTP id u54mr1309739wea.182.1242414330151; 
	Fri, 15 May 2009 12:05:30 -0700 (PDT)
In-Reply-To: <4A0CBE35.6030004@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119279>

On Fri, May 15, 2009 at 1:58 AM, A Large Angry SCM <gitzilla@gmail.com> wrote:

> Standardese, the peculiar dialect and formalism employed by RFC authors, is
> not difficult to master. The difficult part is writing the prose that's an
> _unambiguous_ description of the protocol you're attempting to document.
> There's even a tool, xml2rfc, that will do the formatting for you.

There are also tools for writing unambiguous prose:
http://en.wikipedia.org/wiki/Controlled_natural_language.
They look potentially tedious to use, but I haven't actually tried.

Ealdwulf
