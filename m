From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git://github.com/some/thing.git/?
Date: Tue, 27 Mar 2012 13:47:54 -0500
Message-ID: <20120327184754.GA27070@burratino>
References: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
 <20120327163339.GA5941@sigill.intra.peff.net>
 <7vd37xj3zh.fsf@alter.siamese.dyndns.org>
 <20120327183833.GB8460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:48:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCbRL-0004v0-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab2C0SsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 14:48:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33547 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707Ab2C0SsN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:48:13 -0400
Received: by iagz16 with SMTP id z16so249825iag.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CfVcjzSGWZjcqJtlXILbN4CJSM0n85v1FTHqihcJcGk=;
        b=vpdL/kcBBNCWGabyjnai3bbS6znr/6UGeQ4lIHnmDMLx5CN2a2NEdu9BFa4Z4ICX4A
         Wol7PeOJW5yF/lgCUefkBkyiUy0Ph0+iA+5pVUo6sJ8J7txl8SIYit/Bns06sxrTHnbO
         7D0bnFoJRhJdo0tLkPH113uVwQrNStd+qiCgvJRsijE60veEtNS/RCVL9Aed+9v3GDWt
         55Twhzg8EQrE4FgVcXdwocw6EJpQdrg16RA++WugOKJH9WQiXOMMv3/1YzId8kfCtBGn
         Iu4/XAkhiOE1VcIvWq0ueNcJ3qRxE+g3cXKE2e/7Ve2yIJ2C8OOlnoitGWR96WnNiSSc
         j5LA==
Received: by 10.50.87.225 with SMTP id bb1mr143932igb.13.1332874093509;
        Tue, 27 Mar 2012 11:48:13 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wp5sm507591igc.16.2012.03.27.11.48.08
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 11:48:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120327183833.GB8460@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194074>

Jeff King wrote:

> For some definition of "we"; AFAICT, github has never allowed this, and
> this is the first complaint

I complained and got a dismissive response about two years ago. ;-)  I
am not sure if bugs from back then are tracked any more.  The URL in
my records is [1].

[...]
> However, it turned out to be a one-line patch. I've pushed it out for
> review by other GitHubbers.

Hoorah!  Thanks for taking care of it.

Sincerely,
Jonathan

[1] http://support.github.com/discussions/repos/3046-cannot-access-repository-using-url-with-trailing-slash-is-not-a-valid-repository-name
