From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 07/24] t9300 (fast-import): use tabs to indent
Date: Fri, 24 Sep 2010 14:24:25 +0530
Message-ID: <20100924085424.GD22658@kytes>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
 <20100924071350.GH4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 10:55:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz44T-0006aI-31
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 10:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab0IXIzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 04:55:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39673 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab0IXIzu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 04:55:50 -0400
Received: by pvg2 with SMTP id 2so590472pvg.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vEtyE9WS0VuU4FMP3Qkvz29rljJ3t4xov3q6WeK9WEY=;
        b=OPP5sevrr/wBQ+ApdomSkexcFaMjbrSXEDpKsi0Vehh9gMm8aQt14cUcSIwLTH48B9
         fVtJGifoG2/xBDOyApjNWLlQIg+SHutmdpGndWx1P8+P0Y88DKg/0lODLcP+62/nBFuL
         aP3poHUoMBkHZe0oRoFb/p/D0/A03uWJHhfrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=v9a6r84UgKgNwhxqOA5qCyYPxhODvrJ6hkUKGZRdJTAtUI2r2imA5gxMZmaNYmEbMC
         g1aucebiS6lUViM6Npyo0JZxgJzr/R40URPg42cBOWk5QIxJ1h+jznOgxa6h8eHTe8wv
         u5Gnu4UReih8lc8Chfp8SBvWAy3urA/0AY9YU=
Received: by 10.114.13.2 with SMTP id 2mr3156700wam.155.1285318549733;
        Fri, 24 Sep 2010 01:55:49 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id o17sm3133444wal.9.2010.09.24.01.55.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 01:55:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924071350.GH4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156963>

Hi Jonathan,

Jonathan Nieder writes:
> The test script mostly uses tabs to indent, but some 4-space indents
> snuck in.

Patches 7-24 are boring non-functional changes that involve re-styling
and re-indenting. Maybe put them all in one large commit? It's fairly
trivial to review these changes anyway.

-- Ram
